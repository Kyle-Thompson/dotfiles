#!/bin/bash

# Connection Check TODO


# initial setup
rm -rf ~/.dotfiles
git clone --quiet git@github.com:Kyle-Thompson/.dotfiles.git ~
mkdir -p ~/.config


### media  TODO: Host media somewhere and fetch it here
mkdir -p ~/Pictures/Wallpapers
wget --quiet --output-document=~/Pictures/Wallpapers/deer.jpg


# neovim
#rm -rf ~/.config/nvim
ln -sf ~/.dotfiles/nvim ~/.config/nvim


# git
git config --global user.name "Kyle Thompson"
git config --global user.email "kyle.thompson228@gmail.com"
git config --global user.editor nvim


# i3
#rm -rf ~/.config/i3
ln -sf ~/.dotfiles/i3 ~/.config/i3
