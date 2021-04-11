#!/bin/sh

# Install OhMyZsh
cd "$HOME"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
rm "$HOME/.zshrc"

# Dootfiles
mkdir -p "$HOME/Git" && cd "$HOME/Git"
mkdir -p "$HOME/.doom.d/"
git clone https://github.com/DoppleDankster/dootfiles.git
find "$HOME/Git/dootfiles" -type f -iname "*.sh" -exec chmod +x {} \;
stow -v -R -t ~ dootfiles
. /home/doppledankster/.zshrc


# Install Doom Emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom -y install
~/.emacs.d/bin/doom -y sync

# Python packages
pip install -r /archinstall/packages/python.txt



