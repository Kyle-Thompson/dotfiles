if [ `xrandr --listmonitors | sed -n 1p | cut -c11-` -eq 3 ]; then
    xrandr --output DP-3 --off --output DVI-I-0 --off --output HDMI-0 --mode 1920x1080 --pos 0x264 --rotate normal --output DP-5 --off --output DP-4 --off --output DVI-I-1 --off --output DP-2 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-1 --mode 1680x1050 --pos 3840x384 --rotate normal --output DP-0 --off
fi
