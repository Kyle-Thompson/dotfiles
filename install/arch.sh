#!/bin/bash

# checks
if ! ping -c 1 google.com > /dev/null 2>&1; then
    echo "no internet connection"
    exit 1
fi

install () {
    sudo pacman -Sq --noconfirm $@
}


# git
echo "configure git? [Y/n]"
read -n 1 config_git
if [ -z "$config_git" ] || [ "$config_git" = "Y" ] || [ "$config_git" = 'y' ]; then
    ssh-keygen -t rsa -b 4096 -C "kyle.thompson228@gmail.com"
    ssh-add ~/.ssh/id_rsa
    echo "add id_rsa.pub to github and press [ENTER]"
    read
    install git
    git config --global user.name "Kyle Thompson"
    git config --global user.email "kyle.thompson228@gmail.com"
    git config --global user.editor nvim
fi


# dotfile directory
mkdir -p ~/.config
rm -rf ~/.dotfiles
git clone --quiet git@github.com:Kyle-Thompson/dotfiles.git ~/.dotfiles


# media  TODO: Host media somewhere and fetch it here
curl -s http://i.imgur.com/SpBfUZi.jpg --create-dirs -o ~/Pictures/Wallpapers/deer.jpg


# neovim
install neovim
install python2-pip python-pip
pip2 install --upgrade pip neovim
pip install --upgrade pip neovim
rm -rf ~/.config/nvim
ln -s ~/.dotfiles/nvim ~/.config/nvim


# general WM
install feh thunar

# i3
install i3
rm -rf ~/.config/i3
#chmod +x ~/.dotfiles/etc/monitor-layout.sh
ln -s ~/.dotfiles/i3 ~/.config/i3

# openbox
install openbox
rm -rf ~/.config/openbox
ln -s ~/.dotfiles/openbox ~/.config/openbox


# zsh
# get powerline fonts
#mkdir -p ~/.fonts ~/.config/fontconfig/conf.d
#wget -O ~/.fonts/PowerlineSymbols.otf https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
#wget -O ~/.config/fontconfig/conf.d/10-powerline-symbols.conf https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
install zsh
chsh -s `which zsh`
rm ~/.zshrc
ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc


# termite
install termite
rm -rf ~/.config/termite
ln -s ~/.dotfiles/termite ~/.config/termite


