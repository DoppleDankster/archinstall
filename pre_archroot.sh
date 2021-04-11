#!/bin/sh

# Simple & Automated install script for my arch

# Keyboard
echo "Switching Keyboard layout"
loadkeys fr

# Mirror list
echo "Updating Mirror List"
reflector -c France --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy

# Time
echo "Time to NTP"
timedatectl set-ntp true

# Partitioning / Formatting / Mounting
echo " Setup Partitions"
lsblk

echo " Format Partitions"

# Mount partitions
# [WIP
# Pacstrap Installation
echo "Pacstrap to /mnt"
pacstrap /mnt base base-devel linux linux-firmware amd-ucode git vim wget curl

# Fstab
echo "Generating FSTAB"
genfstab -U /mnt >> /mnt/etc/fstab

echo "Cloning the Installation repo on the new system"
pacman -S --noconfirm git
git clone https://github.com/doppledankster/archinstall /mnt/archinstall
chmod +x /mnt/archinstall/*.sh

printf "\033[1;34m CHROOTING IN \33[0m \n"
arch-chroot /mnt /archinstall/post_archroot.sh

