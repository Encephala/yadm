#!/usr/bin/env bash
set -euo pipefail

# ── Packages ──────────────────────────────────────────────────────────────────

sudo pacman -S --needed --noconfirm zsh

yay -S --needed --noconfirm oh-my-zsh-git

# ── Shell ─────────────────────────────────────────────────────────────────────

if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
    chsh -s /usr/bin/zsh
fi
