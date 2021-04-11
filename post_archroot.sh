#!/bin/sh


colored_print () {
    LENGHT="${#1}"
    printf '\033[1;34m' 
    printf '%*s' $LENGHT | tr ' ' '='
    printf "\n${1}\n"
    printf '%*s' $LENGHT | tr ' ' '='
    printf '\033[0m\n'
}

colored_print "CONFIGURING LOCALES"

# Locale & Time
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc

# Uncomments en_US UTF-8 in locale.gen
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=fr" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
printf "127.0.0.1 localhost\n::1 localhost\n127.0.1.1 arch.localdomain arch" >> /etc/hosts

# Package Install
pacman -S --needed --noconfirm -q - < /archinstall/packages/pacman.txt > /dev/null 

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

colored_print "CONFIGURING USERS"
useradd -m doppledankster --shell /bin/zsh
echo root:password | chpasswd
echo doppledankster:password | chpasswd
echo "doppledankster ALL=(ALL) ALL" > /etc/sudoers.d/doppledankster

colored_print "INSTALLING YAY"
echo "Temporary disabling sudo passwd to install yay"
echo "doppledankster ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/doppledankster
/bin/su -s /bin/bash -c '/archinstall/yay_install.sh' doppledankster
echo "doppledankster ALL=(ALL) ALL" >> /etc/sudoers.d/doppledankster
sed -i '$d' /etc/sudoers.d/doppledankster

colored_print "INSTALLING DOTFILES"
/bin/su -s /bin/bash -c '/archinstall/home_install.sh' doppledankster

# Cleanup
colored_print "CLEANING UP"
cd /
rm -rf /archinstall

printf "\033[0;31mDone! Dont forget to CHANGE the root and user password before rebooting\n\e[0m"
