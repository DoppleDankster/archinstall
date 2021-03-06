#!/bin/sh

# Install OhMyZsh
cd "$HOME"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# SSH
mkdir -p $HOME/.ssh
ssh-keygen -b 4096 -t rsa -C "github" -f $HOME/.ssh/github
ssh-keygen -b 4096 -t rsa -C "github" -f $HOME/.ssh/gitlab
ssh-keygen -b 4096 -t rsa -C "github" -f $HOME/.ssh/server

# Dootfiles

# cloning the dependencies
mkdir -p "$HOME/Git" && cd "$HOME/Git"
mkdir -p "$HOME/.doom.d/"
git clone https://github.com/DoppleDankster/dootfiles.git
find "$HOME/Git/dootfiles" -type f -iname "*.sh" -exec chmod +x {} \;

# seting up everything
rm "$HOME/.zshrc"
mkdir -p $HOME/.config
mkdir -p $HOME/.local

# applying dotfiles
stow -v -R -t ~ dootfiles
. /home/doppledankster/.zshrc


# Install Doom Emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom -y install
~/.emacs.d/bin/doom -y sync

# Python packages
pip install -r /archinstall/packages/python.txt


