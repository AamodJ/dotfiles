#!/bin/sh

# Merge all copy buffers
autocutsel -selection PRIMARY -fork

# Initialise Xresources
xrdb -merge ~/.Xresources &

# Set brightness
xbacklight -set 20

# Set volume
pactl set-sink-volume @DEFAULT_SINK@ 75%

# Set keyboard input delay
xset r rate 250 70

# loop bspwm
# while true; do
# 	bspwm >/dev/null 2>&1
# done

# open bspwm
exec bspwm
