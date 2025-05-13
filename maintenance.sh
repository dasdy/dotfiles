#!/bin/env bash

echo "Upgrading packages"

paru -Syu

echo "Upgrading keyring"

sudo pacman -Sy archlinux-keyring

echo "Pacman cache check:"

sudo ls /var/cache/pacman/pkg/ | wc -l //cached packages

du -sh /var/cache/pacman/pkg/

echo "clearing paccache:"

sudo apccache -r

echo "Removing orphan packages"

sudo pacman -Qtdq | sudo pacman -Rns -

echo "Clearing journals"

journalctl --disk-usage

sudo journalctl --vacuum-time=7d

echo "Look at the cache..."

sudo du -sh ~/.cache
