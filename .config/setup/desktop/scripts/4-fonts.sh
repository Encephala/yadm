#!/usr/bin/env bash
set -euo pipefail

# ── Packages ──────────────────────────────────────────────────────────────────

sudo pacman -S --needed --noconfirm ttf-cascadia-mono-nerd otf-font-awesome noto-fonts-emoji

# ── Fontconfig: set CaskaydiaMono Nerd Font as monospace default ──────────────

sudo tee /etc/fonts/local.conf > /dev/null <<'EOF'
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <alias>
    <family>monospace</family>
    <prefer>
      <family>CaskaydiaMono Nerd Font Mono</family>
    </prefer>
  </alias>
</fontconfig>
EOF

fc-cache -f
