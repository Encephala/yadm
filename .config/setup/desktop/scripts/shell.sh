#!/usr/bin/env bash
set -euo pipefail

if [[ "$SHELL" != "/usr/bin/zsh" ]]; then
    chsh -s /usr/bin/zsh
fi
