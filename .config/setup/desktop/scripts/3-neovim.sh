#!/usr/bin/env bash
set -euo pipefail

# ── Packages ──────────────────────────────────────────────────────────────────

sudo pacman -S --needed --noconfirm neovim gcc npm unzip luarocks

yay -S --needed --noconfirm tree-sitter-cli

# ── kickstart.nvim ────────────────────────────────────────────────────────────

if [[ ! -d "$HOME/.config/nvim" ]]; then
    git clone https://github.com/Encephala/kickstart.nvim "$HOME/.config/nvim"
fi

nvim --headless -c "lua vim.pack.update(nil, { offline = false })" -c "qa"
