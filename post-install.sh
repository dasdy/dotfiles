#!/bin/bash

function add-repositories {
  sudo add-apt-repository ppa:numix/ppa
  sudo add-apt-repository ppa:ubuntu-elisp/ppa
  sudo add-apt-repository ppa:webupd8team/sublime-text-3
  sudo add-apt-repository ppa:webupd8team/atom
  sudo add-apt-repository ppa:webupd8team/java
  sudo add-apt-repository ppa:git-core/ppa
  sudo apt update
}

function install-base {
  sudo apt install -y \
     gitk \
     sqlite3 \
     meld \
     rlwrap  \
     tree \
     keepassx \
     xfonts-terminus \
     console-terminus \
     oracle-java8-installer \
     qbittorrent \
     numix-icon-theme-circle \
     skype \
     python-pip \
     python3-pip \
     numix-gtk-theme \
     terminator \
     emacs \
     git \
     arc-theme \
     caffeine \
     gcc \
     g++ \
     autoconf \
     automake \
     ubuntu-restricted-extras \
     libavcodec-extra \
     pkg-config \
     build-essential \
     fish \
     htop \
     i3  \
     rofi \
     neofetch \
     w3m \
     virtualenv
  sudo pip3 install git-up

}

function install-additional-languages {

    sudo apt install -y \
         mono-devel \
         monodevelop \
         sbcl \
         nodejs \
         npm \
         ghc \
         cabal-install \
         ruby-full

    mkdir ~/bin
    wget -O ~/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
    chmod +x ~/bin/lein
}

function install-dm-dependencies {
    sudo add-apt-repository ppa:aguignard/ppa
    sudo apt-get update
    sudo apt install -y \
         libxcb1-dev \
         libxcb-keysyms1-dev \
         libpango1.0-dev \
         libxcb-util0-dev \
         libxcb-icccm4-dev \
         libyajl-dev \
         libstartup-notification0-dev \
         libxcb-randr0-dev \
         libev-dev \
         libxcb-cursor-dev \
         libxcb-xinerama0-dev \
         libxcb-xkb-dev \
         libxkbcommon-dev \
         libxkbcommon-x11-dev \
         autoconf \
         libxcb-xrm-dev \ cmake \
         cmake-data \
         libcairo2-dev \
         libxcb1-dev \
         libxcb-ewmh-dev \
         libxcb-icccm4-dev \
         libxcb-image0-dev \
         libxcb-randr0-dev \
         libxcb-util0-dev \
         libxcb-xkb-dev \
         pkg-config \
         python-xcbgen \
         xcb-proto \
         libxcb-xrm-dev \
         i3-wm \
         libasound2-dev \
         libmpdclient-dev \
         libiw-dev \
         libcurl4-openssl-dev
}

function add-configs {
  # config manipulations that probably only need to be done once
  mkdir ~/.lein
  ln -s `pwd`/profiles.clj ~/.lein/profiles.clj

  mkdir -p ~/.config/fish/functions
  ln -s `pwd`/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish

  mkdir -p ~/.config/polybar
  ln -s `pwd`/polybar-config ~/.config/polybar/config

  ln -s `pwd`/.i3 ~/.i3
  ln -s `pwd`/.vimrc ~/.vimrc
  ln -s `pwd`/.bashrc ~/.bashrc
  ln -s `pwd`/.emacs.d ~/.emacs.d

  git config --global push.default simple
  git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
}

add-repositories
install-base
install-dm-dependencies
install-additional-languages
add-configs
