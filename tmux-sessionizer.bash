#!/usr/bin/env bash
set -x

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/sandbox ~ -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z "${TMUX}" ]] && [[ -z $tmux_running ]]; then
    echo "pyenv 2&> /dev/null"
    echo "jenv 2&> /dev/null"

    [ -f pyproject.toml ] && echo "poetry shell"
    [ -f pyproject.toml ] || [ -f .python_version ] echo "pyenv 2&> /dev/null"

    
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

# tmux switch-client -t $selected_name
tmux attach -t $selected_name
