#!/bin/bash

# connection check
if ! ping -c 1 google.com > /dev/null 2>&1; then
    echo "no internet connection"
    exit 1
fi


case `lsb_release -si` in
    Ubuntu)
        # neovim
        add-apt-repository -y ppa:neovim-ppa/unstable > /dev/null 2>&1
        apt-get -qq update 

        install () {
            apt-get -qq install $1
        }
        ;;
    *)
        echo "$(lsb_release -si) isn't supported"
        exit 1
        ;;
esac


# git
install git
git config --global user.name "Kyle Thompson"
git config --global user.email "kyle.thompson228@gmail.com"
git config --global user.editor nvim


# dotfile directory
mkdir -p ~/.config
rm -rf ~/.dotfiles
sudo -u $SUDO_USER git clone --quiet git@github.com:Kyle-Thompson/dotfiles.git ~/.dotfiles


### media  TODO: Host media somewhere and fetch it here
curl -s http://i.imgur.com/SpBfUZi.jpg --create-dirs -o ~/Pictures/Wallpapers/deer.jpg


# neovim
install neovim
rm -rf ~/.config/nvim
ln -s ~/.dotfiles/nvim ~/.config/nvim


# i3
install i3
rm -rf ~/.config/i3
ln -s ~/.dotfiles/i3 ~/.config/i3
if [ "${$(xrandr --listmonitors | sed -n 1p): -1}" -eq 3 ]; then
    echo "\n#3-way screen layout\nexec_always xrandr --output DP-3 --off --output DVI-I-0 --off --output HDMI-0 --mode 1920x1080 --pos 0x264 --rotate normal --output DP-5 --off --output DP-4 --off --output DVI-I-1 --off --output DP-2 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-1 --mode 1680x1050 --pos 3840x384 --rotate normal --output DP-0 --off" >> ~/.config/i3/config
fi

