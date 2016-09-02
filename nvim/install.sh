if [ -e ~/.config/nvim ]; then
    rm -rf ~/.config/nvim
fi
ln -s ~/.dotfiles/nvim ~/.config/nvim
