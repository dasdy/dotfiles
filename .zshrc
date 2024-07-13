# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/home/dasd/.oh-my-zsh"
ZSH_THEME="geoffgarside"
DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git timer docker cargo pip rust cp virtualenvwrapper zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

source $HOME/aliases.bash
alias ll='exa -la --group-directories-first'
alias vim=nvim
alias vi=nvim


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/dasd/google-cloud-sdk/path.zsh.inc' ]; then . '/home/dasd/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/dasd/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/dasd/google-cloud-sdk/completion.zsh.inc'; fi


source <(kubectl completion zsh)
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ ! -f /usr/share/fzf/key-bindings.zsh ]] || source /usr/share/fzf/key-bindings.zsh
[[ ! -f /usr/share/fzf/completion.zsh ]] || source /usr/share/fzf/completion.zsh