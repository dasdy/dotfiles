.PHONY: apps-install
apps-install:
	sudo pacman -S --needed - < pkglist.txt

.PHONY: links-setup
links-setup:
	stow */ -t "${HOME}" --dotfiles

.PHONY: brew-dump
package-dump:
	pacman -Qqent > pkglist.txt

.PHONY: all
all: apps-install links-setup
