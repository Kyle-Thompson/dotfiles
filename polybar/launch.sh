#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Get the bar to use
computer=$(cat /etc/hostname)
wm=$(wmctrl -m | head -n 1 | sed "s/^Name:\s//g")
bar=$(echo $computer-$wm | tr '[:upper:]' '[:lower:]')

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload main &
    done
else
    polybar --reload main &
fi
