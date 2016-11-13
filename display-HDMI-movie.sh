#!/bin/sh

# TODO: Set pulseaudio output to HDMI / speakers when switching modes.

if xrandr -q | grep "HDMI-1 connected"; then
    xrandr --output HDMI-1 --auto
    xrandr --output LVDS-1 --off
    pkill redshift
    redshift -x
fi
