#!/bin/bash

# checks
if ! ping -c 1 google.com > /dev/null 2>&1; then
  echo "no internet connection"
  exit 1
fi

# parse args
HOSTNAME=

#   parse

if test -z $HOSTNAME; then
  echo "must provide hostname with flag --hostname=<name>"
  exit 1
fi

# install packages
if ! test -f packages; then
  echo "no packages file"
  exit 1
fi
pacman -S - < packages.txt

# internet
echo "\
[Match]
Name=en*

[Network]
DHCP=ipv4
" > /etc/systemd/network/20-wired.network
systemctl enable systemd-networkd
systemctl enable systemd-resolved
systemctl enable systemd-timedated
systemctl enable dhcpcd.service

# timezone
ln -s /usr/share/zoneinfo/America/New_York /etc/localtime

# locale TODO
# uncomment en_US.UTF-8 in /etc/locale.gen
locale-gen

# hostname
echo $HOSTNAME > /etc/hostname
echo "\
127.0.0.1       localhost
::1             localhost
127.0.1.1       $HOSTNAME.localdomain   $HOSTNAME
" > /etc/hosts

# initramfs
mkinitcpio -P

# root password
passwd

# user account and password TODO
useradd -m -s zsh -g users -G wheel kyle
#  -m: creates home directory for user
#  -s: the default shell for the user
#  -g: make new user's initial group users
#  -G: add user to wheel group (necessary for sudo)
passwd kyle
# uncomment "%wheel ALL=(ALL) ALL" from /etc/sudoers

# bootloader TODO
