#!/bin/bash

# checks
if ! ping -c 1 google.com > /dev/null 2>&1; then
    echo "no internet connection"
    exit 1
fi

install () {
    sudo pacman -S $@
}

ask_config () {
    echo "configure $1 [Y/n]"
    read -n 1 config_section
    return [ -z "$config_section" ]\
        || [ "$config_section" = "Y" ]\
        || [ "$config_section" = 'y' ]
}


# git
echo "configure git? [Y/n]"
read -n 1 config_section
if [ -z "$config_section" ] || [ "$config_section" = "Y" ] || [ "$config_section" = 'y' ]; then
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
echo "Fetch media? [Y/n]"
read -n 1 config_section
if [ -z "$config_section" ] || [ "$config_section" = "Y" ] || [ "$config_section" = 'y' ]; then
	curl -s http://i.imgur.com/SpBfUZi.jpg --create-dirs -o ~/media/wallpapers/deer.jpg
fi


# neovim
echo "configure neovim? [Y/n]"
read -n 1 config_section
if [ -z "$config_section" ] || [ "$config_section" = "Y" ] || [ "$config_section" = 'y' ]; then
	install neovim
	install python2-pip python-pip
	pip2 install --upgrade pip neovim
	pip install --upgrade pip neovim
    pip install jedi # python completion
	rm -rf ~/.config/nvim
	ln -s ~/.dotfiles/nvim ~/.config/nvim
fi


# general WM
echo "configure WMs? [Y/n]"
read -n 1 config_section
if [ -z "$config_section" ] || [ "$config_section" = "Y" ] || [ "$config_section" = 'y' ]; then
	install feh 
	install thunar

	# i3
	install i3
	rm -rf ~/.config/i3
	ln -s ~/.dotfiles/i3 ~/.config/i3

	# openbox
	install openbox
	rm -rf ~/.config/openbox
	ln -s ~/.dotfiles/openbox ~/.config/openbox

    #rofi
    install rofi
    rm -rf ~/.config/rofi
    ln -s ~/.dotfiles/rofi ~/.config/rofi

    #compton
    install compton
    rm -rf ~/.config/compton.conf
    ln -s ~/.dotfiles/compton/compton.conf ~/.config/compton.conf
fi


# zsh
echo "configure zsh? [Y/n]"
read -n 1 config_section
if [ -z "$config_section" ] || [ "$config_section" = "Y" ] || [ "$config_section" = 'y' ]; then
    #mkdir -p ~/.fonts # deprecated
    #wget -O ~/.fonts/PowerlineSymbols.otf https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
    mkdir -p ~/.config/fontconfig/conf.d
    if [ ! -f ~/.config/fontconfig/conf.d/10-powerline-symbols.conf ]; then
        wget -O ~/.config/fontconfig/conf.d/10-powerline-symbols.conf \
            https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
    fi
	install zsh
	chsh -s `which zsh`
	rm ~/.zshrc
	ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
fi


# termite
echo "configure termite? [Y/n]"
read -n 1 config_section
if [ -z "$config_section" ] || [ "$config_section" = "Y" ] || [ "$config_section" = 'y' ]; then
	install termite
	rm -rf ~/.config/termite
	ln -s ~/.dotfiles/termite ~/.config/termite
fi


# polybar
echo "configure polybar? [Y/n]"
read -n 1 config_section
if [ -z "$config_section" ] || [ "$config_section" = "Y" ] || [ "$config_section" = 'y' ]; then
	yaourt polyboar
	rm -rf ~/.config/polybar
	ln -s ~/.dotfiles/polybar ~/.config/polybar
fi


# X
echo "configure X? [Y/n]"
read -n 1 config_section
if [ -z "$config_section" ] || [ "$config_section" = "Y" ] || [ "$config_section" = 'y' ]; then
    rm ~/.xinitrc ~/.Xresources ~/.xbindkeysrc
    ln -s ~/.dotfiles/X/xinitrc ~/.xinitrc
    ln -s ~/.dotfiles/X/Xresources ~/.Xresources
    ln -s ~/.dotfiles/X/xbindkeysrc ~/.xbindkeysrc
fi
