#!/bin/sh

# Locale & Time
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc
# uncomments en_US.UTF-8 in locale.gen
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=fr" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
printf "127.0.0.1 localhost\n::1 localhost\n127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:password | chpasswd

# Package Install
pacman -S --needed --noconfirm -q - < /archinstall/pacman.txt 

# Grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Sys init
systemctl enable NetworkManager
systemctl enable cups
systemctl enable sshd
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable acpid

# User
useradd -m doppledankster --shell /bin/zsh
echo doppledankster:password | chpasswd
echo "doppledankster ALL=(ALL) ALL" > /etc/sudoers.d/doppledankster

# Yay
echo "Temporary disabling sudo passwd to install yay"
echo "doppledankster ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/doppledankster
/bin/su -s /bin/bash -c '/archinstall/yay_install.sh' doppledankster
echo "doppledankster ALL=(ALL) ALL" >> /etc/sudoers.d/doppledankster
sed -i '$d' /etc/sudoers.d/doppledankster


# Home Dir
echo "Deploying dootfiles"
/bin/su -s /bin/bash -c '/archinstall/home_install.sh' doppledankster



printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
