alias docker-stop-all='docker stop $(docker ps -aq)'

alias k-context='kubectl config current-context'
alias kg="kubectl get"

alias k='kubectl'

alias k-pod='kubectl get pods | grep '

alias ls='lsd'
alias ll='ls -l --group-directories-first'
alias la='ls -a --group-directories-first'
alias lla='ls -la --group-directories-first'
# alias lt='ls -l --tree'
lt() {
    lsd -al --tree --git -I'.git' -I'node_modules' -I'.mypy_cache' -I '.pytest_cache' -I '.venv' --color=always "$@" | less -R
}

alias vim=nvim
alias vi=nvim

git-branch-cleanup() {
    git branch -D $(git branch -v | grep gone | tr -s ' ' | cut -f2 -d ' ')
}

alias fzfp="fzf --preview 'bat --color=always {}' --preview-window '~3'"
alias gg=lazygit

# alias tmux="TERM=screen-256color-bce tmux"
# fuzzy-find any directory two layers down, and go there
fzd() {
    local dir
    dir=$(find -L ${1:-.} -maxdepth 2 -type d 2>/dev/null | fzf +m) && cd "$dir"
}

kd() {
    kubectl describe "$1" "$(knm "$1" "$2")"
}

k-switch-context() {
    kubectl config use-context $1
}

k-set-nm() {
    kubectl config set-context "$(kubectl config current-context)" --namespace="$1"
}

k-login() {
    kubectl exec -ti "$(knm pod "$1")" bash
}

k-events() {
    k-pod "$1"
    kd pod "$1" | sed -ne '/^Events/,$p'
}

# lazy loading pyenv so that it does not slow down startup
pyenv() {
    unset -f pyenv
    eval "$(command pyenv init -)"
    eval "$(command pyenv init --path)"
    eval "$(command pyenv virtualenv-init -)"
    pyenv $@
}

# lazy loading jenv so that it does not slow down startup
jenv() {
    unset -f jenv
    eval "$(command jenv init -)"
    jenv $@
}

envinit() {
    echo "pyenv init"
    pyenv 2 &>/dev/null
    if [ -f pyproject.toml ]; then
        echo "poetry init"
        poetry shell -q 2 &>/dev/null
    fi
    echo "jenv init"
    jenv 2 &>/dev/null
}

alias t="tmux-sessionizer"
