#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> system update"
sudo pacman -Syu --noconfirm
which yay >/dev/null && yay -Syu --noconfirm

for script in "$SCRIPT_DIR"/scripts/*.sh; do
    name="$(basename "$script" .sh)"
    name="${name#*-}"
    echo "==> $name"
    bash "$script"
done

# ── Manual steps ──────────────────────────────────────────────────────────────

cat <<'EOF'

Bootstrap complete. Manual steps remaining:

  1. Hyprland local config — create ~/.config/hypr/hyprland-local.conf
       (monitor layout, cursor size, touchpad, brightness keys — device-specific)

  2. Hyprlock local config — create ~/.config/hypr/hyprlock-local.conf

  3. Hyprland GUI config — ~/.config/hypr/hyprland-gui.conf is managed by hyprmod,
       generated automatically on first launch.

  4. Synology Drive — verify the service started; configure sync folders.

  5. Relog for chsh to take effect (or: exec zsh).

EOF
