#!/usr/bin/env bash
set -euo pipefail

# ── kickstart.nvim ────────────────────────────────────────────────────────────

if [[ ! -d "$HOME/.config/nvim" ]]; then
    git clone https://github.com/Encephala/kickstart.nvim "$HOME/.config/nvim"
fi

nvim --headless -c "lua vim.pack.update(nil, { offline = false })" -c "qa"
