# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/dasd/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="geoffgarside"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git timer docker cargo pip rust cp virtualenvwrapper zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#alias ll='ls -lh --color --group-directories-first'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/dasd/google-cloud-sdk/path.zsh.inc' ]; then . '/home/dasd/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/dasd/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/dasd/google-cloud-sdk/completion.zsh.inc'; fi


alias dbuild-ssh='docker build --build-arg SSH_PRIVATE_KEY="$(cat ~/.ssh/id_rsa)"'
alias dcbuild-ssh='docker-compose build --build-arg SSH_PRIVATE_KEY="$(cat ~/.ssh/id_rsa)"'
alias docker-stop-all='docker stop $(docker ps -aq)'
alias brewup='brew update ; brew upgrade; brew cleanup ; brew doctor'

alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
alias vcode='/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron'
alias houndci-check='flake8-diff --flake8-options --config .flake8.ini'

alias beta-db-ssh-tunel='gcloud compute ssh beta-web-1 --ssh-flag "-L 9000:beta-main-db:5432"'
alias main-db-ssh-tunel='gcloud compute ssh beta-web-1 --ssh-flag "-L 9000:main-db-read-replica1:5432"'

alias k-switch-hero='k-switch-context heroes-cluster'
alias k-switch-cluster-1='k-switch-context cluster-1'
alias k-context='kubectl config current-context'
alias kg="kubectl get"

alias k='kubectl'

alias k-pod='kubectl get pods | grep '



function dbuild-push() {
    dbuild-ssh -t $1 . "${@:2}"
    docker push $1
}

function knm-all() {
    kubectl get $1 -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' | /usr/bin/grep $2
}

function knm() {
    knm-all $1 $2  | head -n 1
}

function kd() {
    kubectl describe $1 $(knm $1 $2)
}

function k-switch-context() {
    kubectl config use-context "gke_green-talent-125811_europe-west1-d_$1"
}

function k-login() {
    kubectl exec -ti $(knm pod $1) bash
}

function k-logs() {
    kubectl logs $(knm pod $1) "${@:2}"
}

function k-events() {
    k-pod $1
    kd pod $1 | sed -ne '/^Events/,$p'
}