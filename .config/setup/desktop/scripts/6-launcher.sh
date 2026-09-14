#!/usr/bin/env bash
set -euo pipefail

# ── Packages ──────────────────────────────────────────────────────────────────

yay -S --needed --noconfirm walker elephant elephant-desktopapplications elephant-calc elephant-menus

# ── Services ──────────────────────────────────────────────────────────────────

systemctl --user enable --now elephant.service
systemctl --user enable --now walker.service
