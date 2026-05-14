#!/usr/bin/env bash
set -euo pipefail

# ── pacman ────────────────────────────────────────────────────────────────────

sudo pacman -S --needed --noconfirm base-devel

PACMAN_PACKAGES=(
    # Base
    zsh git curl fzf jq htop less bc

    # Editor
    neovim gcc npm unzip luarocks

    # Hyprland stack
    hyprland waybar hyprlock hyprshot wireplumber brightnessctl playerctl

    # Terminal & files
    kitty dolphin

    # Fonts
    ttf-cascadia-mono-nerd otf-font-awesome noto-fonts-emoji

    # Rust
    rustup

    # Misc
    zoxide age diff-so-fancy starship
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
    gpu-usage-waybar-git
    synology-drive
    vesktop
)

yay -S --needed --noconfirm "${AUR_PACKAGES[@]}"

# ── Rust toolchain ────────────────────────────────────────────────────────────

rustup default stable
