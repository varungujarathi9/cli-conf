# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi



plugins=(git)


export EDITOR=/usr/bin/nvim

alias lg="lazygit"
alias k="kubectl"
alias g="gcloud"
alias d="docker"
alias dc="docker compose"
alias h="helm"
alias tf="terraform"
alias vi="nvim"
alias cat="bat"
alias m="make"

source <(fzf --zsh) # install fzf keybindings

function fcd() {
  local dir
  dir=$(find ${1:-.} -type d -not -path '*/\.*' 2> /dev/null | fzf +m) && cd "$dir"
}

function ktx () {
	kubectx $1
}

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ $commands[kubectl] ]] && source <(kubectl completion zsh) # add autocompletepermanently to your zsh shell
