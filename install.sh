#!/bin/bash

# Store the user's current directory.
user_dir=`pwd`

# Clone the dotfiles repo into ~/.dotfiles.
cd ~
if [ -d ~/.dotfiles ]; then
    echo '.dotfiles already exists. Removing and replacing.'
    rm -rf ~/.dotfiles
fi
`git clone --quiet https://github.com/Kyle-Thompson/dotfiles.git`

# If no ~/.config file exists, make one.
if [ ! -d ~/.config ]; then
    mkdir ~/.config
fi

# TODO: turn this into a loop and check if the files already exist before symlinking
# Symlink directories from dotfiles to config
ln -s ~/.dotfiles/nvim ~/.config/nvim

cd $user_dir
