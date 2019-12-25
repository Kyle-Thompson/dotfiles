#!/bin/bash

# checks
if ! ping -c 1 google.com > /dev/null 2>&1; then
  echo "no internet connection"
  exit 1
fi

# ssh keys
ssh-keygen -b 4096 -t rsa -f ~/.ssh/id_rsa -q -N ""

# make directories
mkdir -p ~/.config/nvim
mkdir ~/{bin,src,dwn,mda,doc}

# src install neovim
git clone git@github.com:neovim/neovim.git ~/src/neovim
pushd ~/src/neovim
make CMAKE_BUILD_TYPE=Release
sudo make install
popd

# src install yay
git clone https://aur.archlinux.org/yay.git ~/src/yay
pushd ~/src/yay
makepkg -si
cd ..
rm -rf yay  # binary self updates
yay -Sq --noconfirm - < ~/.dotfiles/install/aur_packages.txt
popd

# src install st
git clone git@github.com:Kyle-Thompson/st.git ~/src/st
pushd ~/src/st
make
sudo make install
popd

# src install limebar
git clone git@github.com:Kyle-Thompson/limebar.git ~/src/limebar
pushd ~/src/limebar
make
sudo make install
popd

# TODO: src install llvm

# enable services
sudo systemctl enable --now ckb-next-daemon.service
sudo systemctl enable --now nordvpnd.service

# symlinks
ln -s ~/.dotfiles/openbox ~/.config/openbox
ln -s ~/.dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/X/xinitrc
ln -s ~/.dotfiles/bin/* ~/bin/
ln -s ~/.dotfiles/openbox/themes ~/.local/share/themes
ln -s ~/.dotfiles/fonts ~/.local/share/fonts
# TODO: firefox


# update fonts
fc-cache -f
