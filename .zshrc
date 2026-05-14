export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

CASE_SENSITIVE="true"
HIST_STAMPS="yyyy-mm-dd"

export EDITOR="nvim"

plugins=(git per-directory-history)

export PATH="$PATH:$HOME/.local/bin"

source $ZSH/oh-my-zsh.sh

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
