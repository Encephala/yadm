#!/usr/bin/env bash
set -euo pipefail

systemctl --user enable --now elephant.service
systemctl --user enable --now walker.service
