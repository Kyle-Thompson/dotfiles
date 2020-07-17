#!/bin/bash

## checks
if ! ping -c 1 google.com > /dev/null 2>&1; then
  echo "no internet connection"
  exit 1
fi


## ssh keys
ssh-keygen -b 4096 -t rsa -f ~/.ssh/id_rsa -q -N ""
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

cat ~/.ssh/id_rsa.pub
echo "Add the above key to github and hit <enter>"
read -n 1


## make directories
mkdir ~/{.config,bin,doc,dwn,log,mda,mnt,pkg,prj,src,vms}
# bin - executable binaries and scripts
# doc - documents
# dwn - downloads
# log - logs
# mda - general media (pictures, videos, etc)
# mnt - device mount
# pkg - source code for building projects without development intention
# prj - personal projects
# src - source code of projects being developed
# vms - virtual machines


## dotfiles directory
git clone git@github.com:Kyle-Thompson/dotfiles.git ~/.dotfiles
pushd ~/.dotfiles >/dev/null
git submodule init
git submodule update
popd >/dev/null


## clone and build pkg repos
# neovim
git clone https://github.com/neovim/neovim.git ~/pkg/neovim
pushd ~/pkg/neovim >/dev/null
make CMAKE_BUILD_TYPE=Release
sudo make install
popd >/dev/null

# yay
git clone https://aur.archlinux.org/yay.git ~/pkg/yay
pushd ~/pkg/yay >/dev/null
makepkg -si
cd ..
yay -Sq --noconfirm - < ~/.dotfiles/install/aur_packages.txt
popd >/dev/null

# clang
build-clang.sh & 2>&1 >/dev/null


## clone src repos
git clone git@github.com:Kyle-Thompson/st.git      ~/src/st
git clone git@github.com:Kyle-Thompson/limebar.git ~/src/limebar
git clone git@github.com:Kyle-Thompson/dmenu.git   ~/src/dmenu
git clone git@github.com:Kyle-Thompson/stest.git   ~/src/stest


## enable services
sudo systemctl enable --now ckb-next-daemon.service
sudo systemctl enable --now nordvpnd.service


## symlinks
ln -s ~/.dotfiles/openbox        ~/.config
ln -s ~/.dotfiles/nvim           ~/.config
ln -s ~/.dotfiles/zsh/zshrc      ~/.zshrc
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/X/xinitrc      ~/.xinitrc
ln -s ~/.dotfiles/bin/*          ~/bin
ln -s ~/.dotfiles/openbox/themes ~/.local/share
ln -s ~/.dotfiles/fonts          ~/.local/share

ffdir=$(ls ~/.mozilla/firefox/*.default)
mkdir $ffdir/chrome
ln -s ~/.dotfiles/firefox/userChrome.css $ffdir/chrome


## update fonts
fc-cache -f
