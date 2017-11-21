#!/bin/bash
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
convert /tmp/screen.png ~/.config/i3/lock.png -gravity center -composite /tmp/screen.png
i3lock -e -u -i /tmp/screen.png
