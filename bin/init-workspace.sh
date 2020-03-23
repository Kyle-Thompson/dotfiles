#!/bin/sh

name=$1

if test -z $name; then
  echo Error: must supply a name
  exit 1
elif ! test -d ~/src/$name; then
  echo Error: ~/src/$name does not exist
  exit 1
fi

cd ~/src/$name

tmux new-session -s $name -n code -d \; \
  new-window -n build \; \
  new-window -n git \; \
  new-window -n shells \; \
  next-window
