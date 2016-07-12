#!/bin/sh

# TODO: Set pulseaudio output to HDMI / speakers when switching modes.

if xrandr -q | grep "HDMI1 connected"; then
    xrandr --output HDMI1 --auto
    xrandr --output LVDS1 --off
    pkill redshift
    redshift -x
fi
