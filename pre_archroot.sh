#!/bin/sh

# Simple & Automated install script for my arch
printf "\033[1;34m===============================\n"
printf "      AUTO ARCH INSTALLER\n"
printf "===============================\033[0m\n"

loadkeys fr
# Mirror list
echo "Updating the mirror list ..."
reflector -c France --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syy > /dev/null
timedatectl set-ntp true
pacstrap /mnt base base-devel linux linux-firmware amd-ucode git vim wget curl
genfstab -U /mnt >> /mnt/etc/fstab

# Cloning
echo "Cloning the Installation repo on the new system"
pacman -S -q --noconfirm git > /dev/null
git clone https://github.com/doppledankster/archinstall /mnt/archinstall
chmod +x /mnt/archinstall/*.sh

printf "\033[1;34m===============================\n"
printf " ARCH-ROOTING ON THE NEW SYSTEM\n"
printf "===============================\033[0m\n"

arch-chroot /mnt /archinstall/post_archroot.sh

