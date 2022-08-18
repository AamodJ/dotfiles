#!/bin/sh

# Merge all copy buffers
autocutsel -selection PRIMARY -fork

# Initialise Xresources
xrdb -merge ~/.config/X11/.Xresources &

# Set brightness
sudo brillo -S 15
sudo brillo -S 0 -k

# Set volume
pactl set-sink-volume @DEFAULT_SINK@ 75%

# Set keyboard input delay
xset r rate 250 70

# Bind caps to escape and make both shift press = caps
setxkbmap -option caps:escape,shift:both_capslock & 

# Cleanup error file location
ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"

# loop bspwm
# while true; do
# 	bspwm >/dev/null 2>&1
# done

# Start daemons
volnoti -t 1
dunst &
# open bspwm
exec bspwm
