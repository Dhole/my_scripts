#!/bin/sh

if xrandr -q | grep "VGA1 connected"; then
    xrandr --output VGA1 --auto
    xrandr --output LVDS1 --off
    pkill redshift
    redshift -x
fi
