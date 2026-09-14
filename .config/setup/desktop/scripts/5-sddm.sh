#!/usr/bin/env bash
set -euo pipefail

# ── Packages ──────────────────────────────────────────────────────────────────

yay -S --needed --noconfirm sddm-theme-tokyo-night-git

# ── SDDM: set tokyo-night as the active theme ──────────────────────────────────

sudo mkdir -p /etc/sddm.conf.d

sudo tee /etc/sddm.conf.d/theme.conf > /dev/null <<'EOF'
[Theme]
Current=tokyo-night
EOF
