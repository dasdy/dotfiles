.PHONY: brew-install
brew-install:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.PHONY: apps-install
apps-install:
	brew bundle --file=./brew/Brewfile

.PHONY: links-setup
links-setup:
	stow */ -t $HOME

.PHONY: brew-dump
brew-dump:
	brew bundle dump --file=./brew/Brewfile

.PHONY: all
all: brew-install apps-install links-setup
