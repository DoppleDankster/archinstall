#!/bin/sh

cd $HOME
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si 
cd $HOME
echo "Cleaning Up Yay install folder"
rm -rf $HOME/yay-git
echo "Installing Yay packages"
yay -Syu -q --noconfirm
yay -S -q --noconfirm - < /archinstall/packages/yay.txt
