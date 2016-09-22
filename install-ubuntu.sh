#!/bin/bash

# check
if [ "$EUID" -ne 0 ]; then
    echo "must be root"
    exit 1
fi

if ! ping -c 1 google.com > /dev/null 2>&1; then
    echo "no internet connection"
    exit 1
fi

install () {
    apt-get -qq install $1
}

as_user () {
    sudo -u $SUDO_USER $@
}


# git
sudo -u $SUDO_USER ssh-keygen -t rsa -b 4096 -C "kyle.thompson228@gmail.com"
sudo -u $SUDO_USER ssh-add ~/.ssh/id_rsa
echo "add id_rsa.pub to github and press [ENTER]"
read
install git
git config --global user.name "Kyle Thompson"
git config --global user.email "kyle.thompson228@gmail.com"
git config --global user.editor nvim


# dotfile directory
mkdir -p ~/.config
rm -rf ~/.dotfiles
sudo -u $SUDO_USER git clone --quiet git@github.com:Kyle-Thompson/dotfiles.git ~/.dotfiles


# media  TODO: Host media somewhere and fetch it here
as_user curl -s http://i.imgur.com/SpBfUZi.jpg --create-dirs -o ~/Pictures/Wallpapers/deer.jpg


# neovim
add-apt-repository -y ppa:neovim-ppa/unstable > /dev/null 2>&1
apt-get -qq update 
install neovim
install python-pip python3-pip # needed for deoplete
pip install --upgrade pip neovim
pip3 install --upgrade pip neovim
#pip install neovim
#pip3 install neovim
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



