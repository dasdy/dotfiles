alias docker-stop-all='docker stop $(docker ps -aq)'

alias k-context='kubectl config current-context'
alias kg="kubectl get"

alias k='kubectl'

EZA_F='--group-directories-first'
alias ls='eza $EZA_F'
alias ll='eza -l $EZA_F'
alias la='eza -a $EZA_F'
alias lla='eza -la $EZA_F'
alias k-pod='kubectl get pods | grep '

alias cat='bat -p'
# alias fd='fd -H'

alias gg=lazygit

lt() {
    eza -alT --git-ignore $EZA_F -I'.git|node_modules|.mypy_cache|.pytest_cache|.venv' --color=always "$@" | less -R
}

alias vim=nvim
alias vi=nvim
function knm-all() {
    kubectl get "$1" -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' | /usr/bin/grep "$2"
}

git-branch-cleanup() {
    local branches
    branches=$(git branch -v | grep gone | tr -s ' ' | cut -f2 -d ' ')

    git branch -D "${branches[@]}"
}

knm() {
    kubectl get "$1" | grep "$2" | sort | cut -f1 -d ' '
}

kd() {
    kubectl describe "$1" "$(knm "$1" "$2")"
}

k-switch-context() {
    kubectl config use-context "$1"
}

k-list-context() {
    kubectl config get-contexts
}

k-set-nm() {
    kubectl config set-context "$(kubectl config current-context)" --namespace="$1"
}

# lazy loading pyenv so that it does not slow down startup
pyenv() {
    unset -f pyenv
    eval "$(command pyenv init -)"
    eval "$(command pyenv init --path)"
    eval "$(command pyenv virtualenv-init -)"
    pyenv "${@}"
}

# lazy loading jenv so that it does not slow down startup
jenv() {
    unset -f jenv
    eval "$(command jenv init -)"
    jenv "${@}"
}

envinit() {
    echo "pyenv init"
    pyenv 2 &>/dev/null
    if [ -f pyproject.toml ]; then
        echo "poetry init"
        poetry shell -q 2 &>/dev/null
    fi
    # echo "jenv init"
    # jenv 2 &>/dev/null
}

alias t="tmux-sessionizer"
