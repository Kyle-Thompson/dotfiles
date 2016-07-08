#!/bin/bash

# Store the user's current directory.
user_dir=`pwd`

# Create a home for the dotfiles.
if [ ! -d ~/.dotfiles ]; then
    mkdir ~/.dotfiles
else
    echo "~/.dotfiles already exists. Exiting."
    exit
fi

# Clone the dotfiles repo into ~/.dotfiles.
cd ~/.dotfiles
`git clone https://github.com/Kyle-Thompson/dotfiles.git`

# If no ~/.config file exists, make one.
if [ ! -d ~/.config ]; then
    mkdir ~/.config
fi

# TODO: turn this into a loop and check if the files already exist before symlinking
# Symlink directories from dotfiles to config
ln -s ~/.dotfiles/dotfiles/nvim ~/.config/nvim

cd $user_dir
