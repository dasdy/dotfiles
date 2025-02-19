# TODO: figure out how to re-enable it, does not seem to be a way for it, only with warning
# Right now the workaround is to use powerlevel10k
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

export PATH=/opt/homebrew/bin:$PATH
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export PYENV_ROOT=$XDG_DATA_HOME/pyenv
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export K9SCONFIG="$XDG_CONFIG_HOME"/k9s

export GOBIN="$HOME/go/bin"

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$HOME/.jenv/bin:$PATH"

export TERM="xterm-256color"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"

# User configuration
HISTFILE="$HOME/.config/zsh/.zsh_history"
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.


# >>> coursier install directory >>>
export PATH="$PATH:/Users/opodze/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<
