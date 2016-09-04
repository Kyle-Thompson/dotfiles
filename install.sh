#!/bin/bash

# Connection Check TODO


# initial setup
user_dir=`pwd`

cd ~
rm -rf ~/.dotfiles
git clone --quiet https://github.com/Kyle-Thompson/.dotfiles.git

mkdir -p ~/.config

cd $user_dir


### media  TODO: Host media somewhere and fetch it here

mkdir -p ~/Pictures/Wallpapers
wget --quiet --output-document=~/Pictures/Wallpapers/deer.jpg


# neovim
rm -rf ~/.config/nvim
ln -s ~/.dotfiles/nvim ~/.config/nvim


# git
git config --global user.name "Kyle Thompson"
git config --global user.email "kyle.thompson228@gmail.com"
git config --global user.editor nvim


# i3
rm -rf ~/.config/i3
ln -s ~/.dotfiles/i3 ~/.config/i3
