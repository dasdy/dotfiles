#!/bin/env bash

# There are submodules within submodules, and git doesn't seem to handle that too well - so I'm just cloning things here for simplicity.
git clone --depth=1 https://github.com/tmux-plugins/tpm ./tmux/dot-config/tmux/plugins/tpm
git clone --depth=1 https://github.com/tmux-plugins/tmux-sensible.git ./tmux/dot-config/tmux/plugins/tmux-sensible
git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ./zsh/dot-config/zsh/plugins/oh-my-zsh
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ./zsh/dot-config/zsh/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ./zsh/dot-config/zsh/themes/powerlevel10k


bat cache --build
