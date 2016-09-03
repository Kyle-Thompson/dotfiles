#!/bin/bash

### Initial setup ###
user_dir=`pwd`

cd ~
if [ -d ~/.dotfiles ]; then
    echo '.dotfiles already exists. Removing and replacing.'
    rm -rf ~/.dotfiles
fi
`git clone --quiet https://github.com/Kyle-Thompson/.dotfiles.git`

if [ ! -d ~/.config ]; then
    mkdir ~/.config
fi

cd $user_dir



### Text Editors

# neovim
if [ -e ~/.config/nvim ]; then
    rm -rf ~/.config/nvim
fi
ln -s ~/.dotfiles/nvim ~/.config/nvim



### Version Control

# git
git config --global user.name "Kyle Thompson"
git config --global user.email "kyle.thompson228@gmail.com"
git config --global user.editor nvim



### Desktop Environments and Window Managers

# i3
if [ -e ~/.config/i3 ]; then
    rm -rf ~/.config/i3
fi
ln -s ~/.dotfiles/i3 ~/.config/i3
