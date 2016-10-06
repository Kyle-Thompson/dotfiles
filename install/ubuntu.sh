#!/bin/bash

# checks
if [ "$EUID" -ne 0 ]; then
    echo "must be root"
    exit 1
fi

if ! ping -c 1 google.com > /dev/null 2>&1; then
    echo "no internet connection"
    exit 1
fi

install () {
    apt-get -qq install $1 # might need $@
}

as_user () {
    sudo -u $SUDO_USER $@
}


# git
as_user ssh-keygen -t rsa -b 4096 -C "kyle.thompson228@gmail.com"
as_user ssh-add ~/.ssh/id_rsa
echo "add id_rsa.pub to github and press [ENTER]"
read
install git
as_user git config --global user.name "Kyle Thompson"
as_user git config --global user.email "kyle.thompson228@gmail.com"
as_user git config --global user.editor nvim


# dotfile directory
as_user mkdir -p ~/.config
rm -rf ~/.dotfiles
as_user git clone --quiet git@github.com:Kyle-Thompson/dotfiles.git ~/.dotfiles


# media  TODO: Host media somewhere and fetch it here
as_user curl -s http://i.imgur.com/SpBfUZi.jpg --create-dirs -o ~/Pictures/Wallpapers/deer.jpg


# neovim
add-apt-repository -y ppa:neovim-ppa/unstable > /dev/null 2>&1
apt-get -qq update 
install neovim
install python-pip python3-pip
pip install --upgrade pip neovim
pip3 install --upgrade pip neovim
rm -rf ~/.config/nvim
ln -s ~/.dotfiles/nvim ~/.config/nvim
# nvim +PlugInstall +qa


# i3
install feh
install i3
rm -rf ~/.config/i3
chmod +x ~/.dotfiles/etc/monitor-layout.sh
ln -s ~/.dotfiles/i3 ~/.config/i3


# zsh
install zsh
chsh -s `which zsh`
# change dotfile path in zsh etc dir or something
#ln -s ~/.dotfiles/zsh ~/.config/zsh



