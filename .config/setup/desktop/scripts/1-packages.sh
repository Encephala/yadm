#!/usr/bin/env bash
set -euo pipefail

# ── pacman ────────────────────────────────────────────────────────────────────

sudo pacman -S --needed --noconfirm base-devel

PACMAN_PACKAGES=(
    # Base
    git curl fzf jq htop less bc wl-clipboard

    # Editor
    obsidian zed

    # Hyprland stack
    hyprland waybar hyprlock hypridle hyprshot wireplumber brightnessctl playerctl pavucontrol

    # Terminal & files
    kitty dolphin starship zoxide diff-so-fancy

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
    hyprmod
    synology-drive
    vesktop
)

yay -S --needed --noconfirm "${AUR_PACKAGES[@]}"

# ── Rust toolchain ────────────────────────────────────────────────────────────

rustup default stable

