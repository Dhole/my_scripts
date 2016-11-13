#!/bin/sh

if xrandr -q | grep "VGA-1 connected"; then
    xrandr --output VGA-1 --auto
    xrandr --output LVDS-1 --off
    pkill redshift
    redshift -x
fi
