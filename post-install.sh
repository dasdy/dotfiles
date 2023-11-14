#!/bin/bash
function install-soft {
  brew install bat\
    coreutils \
    fzf\
    fd\
    git\
    git-gui\
    go\
    jdupes\
    jenv\
    lsd\
    neofetch\
    neovim\
    pre-commit \
    pyenv\
    ripgrep\
    shellcheck \
    sqlite\
    tree\
    virtualenv\
    youtube-dl\
    zsh-syntax-highlighting
  brew install --cask calibre\
    eloston-chromium\
    iterm2\
    jupyter-notebook-viewer\
    keepassxc\
    obsidian\
    qlstephen\
    rectangle\
    visual-studio-code\
    xnviewmp
}

function add-configs {
  # config manipulations that probably only need to be done once
  git config --global push.default simple
  git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
}

install-soft
add-configs
