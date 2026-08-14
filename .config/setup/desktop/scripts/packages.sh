#!/usr/bin/env bash
set -euo pipefail

# ── pacman ────────────────────────────────────────────────────────────────────

sudo pacman -S --needed --noconfirm base-devel

PACMAN_PACKAGES=(
    # Base
    zsh git curl fzf jq htop less bc wl-clipboard

    # Editor
    neovim gcc npm unzip luarocks zeditor obsidian zed

    # Hyprland stack
    hyprland waybar hyprlock hyprshot wireplumber brightnessctl playerctl pavucontrol

    # Terminal & files
    kitty dolphin starship zoxide diff-so-fancy

    # Fonts
    ttf-cascadia-mono-nerd otf-font-awesome noto-fonts-emoji

    # Rust
    rustup

    # Misc
    age
)

sudo pacman -S --needed --noconfirm "${PACMAN_PACKAGES[@]}"

# ── yay ───────────────────────────────────────────────────────────────────────

if ! command -v yay &>/dev/null; then
    rm -rf /tmp/yay
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si --noconfirm)
    rm -rf /tmp/yay
fi

AUR_PACKAGES=(
    hyprlauncher
    hyprmod
    synology-drive
    vesktop
    tree-sitter-cli
    oh-my-zsh-git
    sddm-theme-tokyo-night-git
)

yay -S --needed --noconfirm "${AUR_PACKAGES[@]}"

# ── Rust toolchain ────────────────────────────────────────────────────────────

rustup default stable

