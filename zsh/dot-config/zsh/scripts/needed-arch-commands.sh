#!/bin/env bash

setup_paru() {
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
}

rustup-setup() {
    rustup default stable
}

call_chris_titus_util() {
    curl -fsSL https://christitus.com/linux | sh
}

arch_mirrors() {
    url="https://archlinux.org/mirrorlist/?country=CZ&country=DE&protocol=https&use_mirror_status=on"
    curl -s $url | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 10 -
}

tldr_setup() {
    sudo pacman -S --needed tealdeer
    tldr --update
}

timeshift_cron_enable() {
    systemctl enable --now cronie.service
}
