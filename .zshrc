export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

CASE_SENSITIVE="true"
HIST_STAMPS="yyyy-mm-dd"

export EDITOR="nvim"

plugins=(git per-directory-history)

source $ZSH/oh-my-zsh.sh

# Aliases
alias vim="nvim"

## Git aliases
alias gl="git log --oneline -n10"
alias gs="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias gp="git push --all"
alias gr="git reset"
alias ga="git add"
alias gc="git commit"
alias gcan="git commit --amend --no-edit"

## CD git root
cdgr() {
    local root
    root=$(git rev-parse --show-toplevel) || return $?
    cd $root || return $?
}

## z (zoxide) git root
zgr() {
    local root
    root=$(git rev-parse --show-toplevel) || return $?
    z $root || return $?
}

## Cargo aliases
alias ctw="cargo test --workspace"

ctp() {
    cargo test -p $(echo $1 | tr -d '/') ${@:2}
}

alias ccw="cargo clippy --workspace"

ccp() {
    cargo clippy -p $(echo $1 | tr -d '/') ${@:2}
}


# Environment
export PATH="$PATH:$HOME/.local/bin"

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
