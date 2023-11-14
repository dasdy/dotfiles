#!/bin/bash
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
export TERM=xterm-color
export CLICOLOR=1
export LSCOLORS=fxfxcxdxbxegedabagacad
export PS1='\[\e[0;33m\]\u\[\e[0m\]@\[\e[0;32m\]\h\[\e[0m\]:\[\e[0;34m\]\w\[\e[0m\]\$ '
export HOMEBREW_NO_GITHUB_API=T
alias grep='grep --color=always'
alias ll='gls -lh --color --group-directories-first'

export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3.6

source $HOME/aliases.bash
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /Library/Frameworks/Python.framework/Versions/3.6/bin/virtualenvwrapper.sh

export PATH="${PATH}:/Users/dasd/bin"

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
export PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH="/Library/Frameworks/GDAL.framework/Versions/Current/Programs/:${PATH}"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dasd/google-cloud-sdk/path.bash.inc' ]; then . '/Users/dasd/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dasd/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/dasd/google-cloud-sdk/completion.bash.inc'; fi


source <(kubectl completion bash)
source /usr/local/etc/bash_completion.d/git-completion.bash

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$HOME/.poetry/bin:$PATH"
