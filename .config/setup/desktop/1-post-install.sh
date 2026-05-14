#!/usr/bin/env bash
set -euo pipefail

# Run this from the archinstall environment, before first reboot.
# Usage: post-install.sh <device> <luks-uuid>
#   e.g. post-install.sh /dev/nvme0n1 abc123-...

DEVICE="${1:?usage: post-install.sh <device> <luks-uuid>}"
LUKS_UUID="${2:?usage: post-install.sh <device> <luks-uuid>}"

# ── LUKS/TPM enrolment ────────────────────────────────────────────────────────

systemd-cryptenroll "$DEVICE" --tpm2-device=auto

# ── GRUB ──────────────────────────────────────────────────────────────────────

GRUB_CONF="/etc/default/grub"

if ! grep -q "rd.luks.name" "$GRUB_CONF"; then
    # Append to whatever value archinstall may have already set
    sed -i "s/GRUB_CMDLINE_LINUX=\"\(.*\)\"/GRUB_CMDLINE_LINUX=\"\1 rd.luks.name=UUID=${LUKS_UUID}=cryptroot\"/" "$GRUB_CONF"
    grep -q "rd.luks.name" "$GRUB_CONF" || { echo "ERROR: failed to patch $GRUB_CONF — edit it manually"; exit 1; }
fi

grub-mkconfig -o /boot/grub/grub.cfg

# ── mkinitcpio ────────────────────────────────────────────────────────────────

MKINIT_CONF="/etc/mkinitcpio.conf"

sed -i 's/^HOOKS=.*/HOOKS=(base systemd autodetect microcode modconf kms keyboard sd-vconsole block sd-encrypt filesystems fsck)/' "$MKINIT_CONF"

mkinitcpio -P

echo
echo "Done. You can now reboot, then run bootstrap.sh."
