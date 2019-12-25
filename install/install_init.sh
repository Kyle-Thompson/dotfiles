#!/bin/bash

# checks
if ! ping -c 1 google.com > /dev/null 2>&1; then
  echo "no internet connection"
  exit 1
fi

# parse args
DISK=

if test -z $DISK; then
  echo "must provide disk to operate on with flag --disk=<disk>"
  exit 1
fi

# partition disk

# total memory for swap
ramG=$(($(cat /proc/meminfo | grep MemTotal | awk '{print $2}') / 1024 / 1024))

# format disk

# mount disk


# pacstrap
pacstrap /mnt base linux linux-firmware

# generate filesystem table
genfstab -U /mnt > /mnt/etc/fstab
