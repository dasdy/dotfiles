# Setup

Using `stow`: `stow */ -t $HOME`
If you want to ignore something, add regex: `stow */ -t $HOME --ignore=.zshrc`

# Homebrew

Installing should look like this:
```shell
brew bundle install --file=brew/Brewfile
```

To make a new brewfile, use:
```shell
brew bundle dump --file=brew/Brewfile
```
