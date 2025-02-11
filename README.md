# Setup

The shortest way is to do:
```shell
make all
```

## Step-by-step:

1. Install Homebrew
2. Install things from brewfile: `brew bundle install --file=brew/Brewfile`
3. Use `GNU Stow` for links setup: `stow */ -t $HOME`
If you want to ignore something, add regex: `stow */ -t $HOME --ignore=.zshrc`


## Sidenotes

To make a new brewfile, use:
```shell
brew bundle dump --file=brew/Brewfile
```

## tmux

`tmux` is a bit special - it needs additional steps after cloning:
1. Initialize submodules

```bash
git pull --recurse-submodules
```
2. Install plugins. This is done by running `C-b I` after running tmux.
