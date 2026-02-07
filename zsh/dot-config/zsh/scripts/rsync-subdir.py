#!/usr/bin/env -S uv run --script
#
# /// script
# requires-python = ">=3.12"
# ///

import argparse
import shlex
import subprocess
import sys
import traceback
from pathlib import Path

RSYNC_ARGS = ["rsync", "-armuv", "--progress", "-h"]


def _as_rsync_dir(p: Path) -> str:
    """Return a string path with a trailing slash, for rsync directory semantics."""
    s = str(p)
    return s if s.endswith("/") else s + "/"


def _quote_cmd(cmd: list[str]) -> str:
    """Pretty-print a command safely (POSIX-ish quoting)."""
    return " ".join(shlex.quote(x) for x in cmd)


def iter_immediate_subdirs(root: Path) -> list[Path]:
    """Return immediate child directories of root, sorted by name.
    Symlinks to directories are included.
    """
    dirs: list[Path] = []
    for child in root.iterdir():
        try:
            if child.is_dir():
                dirs.append(child)
        except OSError:
            # Permission issues, broken symlinks, etc.
            print(f"Error handling path {child}:")
            print(traceback.format_exc())
            continue

    # Stable ordering
    dirs.sort(key=lambda p: p.name.casefold())
    return dirs


def ask_yes_no(prompt: str) -> bool:
    while True:
        ans = input(prompt).strip().lower()
        if ans in {"y", "yes"}:
            return True
        if ans in {"n", "no"}:
            return False
        print("Please answer 'y' or 'n'.")


def parse_index_ranges(raw_input: str) -> set[int]:
    """Parse a string like '1-3, 5, 7' into a set of integers."""
    res = set()
    for part in raw_input.split(","):
        part = part.strip()
        if not part:
            continue
        if "-" in part:
            try:
                start_s, end_s = part.split("-", 1)
                start, end = int(start_s), int(end_s)
                res.update(range(start, end + 1))
            except ValueError:
                print(f"Warning: ignoring invalid range '{part}'")
        else:
            try:
                res.add(int(part))
            except ValueError:
                print(f"Warning: ignoring invalid number '{part}'")
    return res


def get_args():
    parser = argparse.ArgumentParser(
        prog="rsync-dirs",
        description=(
            "Rsync each immediate subdirectory of SOURCE_ROOT into TARGET_ROOT "
            "(one rsync invocation per directory)."
        ),
    )
    parser.add_argument(
        "source_root",
        help="Source root directory (e.g. ~/Google Drive)",
    )
    parser.add_argument("target_root", help="Target root directory (e.g. /Volumes/T7)")
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Print commands, do not execute.",
    )

    return parser.parse_args()


def main(args: argparse.Namespace) -> int:
    """Main entry point."""
    # Expand ~, resolve relative paths, but do NOT require that target exists yet.
    source_root = Path(args.source_root).expanduser().resolve()
    target_root = Path(args.target_root).expanduser().resolve()

    if not source_root.exists():
        print(f"ERROR: Source root does not exist: {source_root}", file=sys.stderr)
        return 2
    if not source_root.is_dir():
        print(f"ERROR: Source root is not a directory: {source_root}", file=sys.stderr)
        return 2

    subdirs = iter_immediate_subdirs(source_root)

    if not subdirs:
        print(f"No subdirectories found under: {source_root}")
        return 0

    planned_cmds: list[list[str]] = []

    for d in subdirs:
        src_dir = _as_rsync_dir(d)
        dst_dir = _as_rsync_dir(target_root / d.name)

        cmd = [*RSYNC_ARGS, src_dir, dst_dir]
        planned_cmds.append(cmd)

    print("Planned rsync commands:\n")
    for i, cmd in enumerate(planned_cmds, start=1):
        print(f"{i}. {_quote_cmd(cmd)}")
    print()

    if args.dry_run:
        print("Dry run enabled: not executing anything.")
        return 0

    subset_prompt = input(
        "Enter indices to **run** (e.g. '1-3, 7') or press Enter to keep all: "
    ).strip()
    if subset_prompt:
        ranges = parse_index_ranges(subset_prompt)
        # Filter (1-based index)
        planned_cmds = [
            cmd for i, cmd in enumerate(planned_cmds, start=1) if i in ranges
        ]

        if not planned_cmds:
            print("All commands skipped. Exiting.")
            return 0

        print("\nRevised plan:\n")
        for i, cmd in enumerate(planned_cmds, start=1):
            print(f"{i}. {_quote_cmd(cmd)}")
        print()

    if not ask_yes_no(f"Run these {len(planned_cmds)} rsync commands? [y/n]: "):
        print("Aborted.")
        return 1

    # Execute sequentially, streaming output directly to the terminal.
    for i, cmd in enumerate(planned_cmds, start=1):
        print(f"\n==> ({i}/{len(planned_cmds)}) Running:")
        print(_quote_cmd(cmd))
        print()

        # Important: no shell=True, so spaces/bad chars are handled safely.
        proc = subprocess.run(cmd, check=False)
        if proc.returncode != 0:
            print(
                f"\nERROR: rsync failed with exit code {proc.returncode}. Stopping.",
                file=sys.stderr,
            )
            return proc.returncode

    print("\nDone.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(get_args()))
