#!/bin/bash

# Store the user's current directory.
user_dir=`pwd`

# Clone the dotfiles repo into ~/.dotfiles.
cd ~
if [ -d ~/.dotfiles ]; then
    echo '.dotfiles already exists. Removing and replacing.'
    rm -rf ~/.dotfiles
fi
`git clone --quiet https://github.com/Kyle-Thompson/.dotfiles.git`

# If no ~/.config file exists, make one.
if [ ! -d ~/.config ]; then
    mkdir ~/.config
fi

#ln -s ~/.dotfiles/nvim ~/.config/nvim
for f in *; do
    if [ -d $f ]; then
        `chmod +x ${f}/install.sh`
        ./${f}/install.sh
    fi
done

cd $user_dir
