.PHONY: brew-install
brew-install:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.PHONY: apps-install-macos apps-install-arch
apps-install:
	brew bundle --file=./brew/Brewfile

apps-install-arch:
	sudo pacman -S --needed - < pkglist.txt

.PHONY: links-setup
links-setup:
	stow */ -t "${HOME}" --dotfiles

.PHONY: brew-dump package-dump
brew-dump:
	brew bundle dump --file=./brew/Brewfile

package-dump:
	pacman -Qqent > pkglist.txt

.PHONY: all-macos all-arch
all-macos: brew-install apps-install links-setup
all-arch: apps-install links-setup
