alias docker-stop-all='docker stop $(docker ps -aq)'

alias k-context='kubectl config current-context'
alias kg="kubectl get"

alias k='kubectl'

alias k-pod='kubectl get pods | grep '

alias gconf-set='gcloud config configurations activate'
alias gconf-get='gcloud config configurations list'

alias ls='lsd'
alias ll='ls -l --group-directories-first'
alias la='ls -a --group-directories-first'
alias lla='ls -la --group-directories-first'
# alias lt='ls -l --tree'
lt() { lsd -al --tree --git -I'.git|node_modules|.mypy_cache|.pytest_cache|.venv' --color=always "$@" | less -R; }
alias vim=nvim
alias vi=nvim
git-branch-cleanup() { git branch -D $(git branch -v | grep gone | tr -s ' ' | cut -f2 -d ' ') }
alias fzfp="fzf --preview 'bat --color=always {}' --preview-window '~3'"
alias gg=lazygit

function dbuild-push() {
    dbuild-ssh -t "$1" . "${@:2}"
    docker push "$1"
}

function knm-all() {
    kubectl get "$1" -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' | /usr/bin/grep "$2"
}

function knm() {
    knm-all "$1" "$2"  | head -n 1
}

function kd() {
    kubectl describe "$1" "$(knm "$1" "$2")"
}

function k-switch-context() {
    kubectl config use-context $1
}

function k-set-nm () {
    kubectl config set-context "$(kubectl config current-context)" --namespace="$1"
}

function k-login() {
    kubectl exec -ti "$(knm pod "$1")" bash
}

function k-logs() {
    kubectl logs "$(knm pod "$1")" "${@:2}"
}

function k-events() {
    k-pod "$1"
    kd pod "$1" | sed -ne '/^Events/,$p'
}
