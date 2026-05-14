export ZSH="$HOME/.oh-my-zsh"

CASE_SENSITIVE="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(per-directory-history zoxide emoji-clock diff-so-fancy)

source $HOME/.cargo/env

source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.local/bin:$PATH"
export EDITOR="vim"

eval "$(starship init zsh)"
