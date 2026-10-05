#!/usr/bin/env bash
set -euo pipefail

# ── Packages ──────────────────────────────────────────────────────────────────

yay -S --needed --noconfirm walker elephant elephant-desktopapplications elephant-calc elephant-menus

# ── Services ──────────────────────────────────────────────────────────────────

# elephant.service and walker.service are started from hyprland.lua's
# hyprland.start hook, not enabled here: plain Hyprland never activates
# graphical-session.target, and default.target starts before a display exists.
