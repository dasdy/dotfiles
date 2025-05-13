#!/bin/env bash


setup_paru() {
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
}

rustup default stable

call_chris_titus_util() {
    curl -fsSL https://christitus.com/linux | sh
}

tldr_setup() {
    sudo pacman -S --needed tealdeer
    tldr --update
}
