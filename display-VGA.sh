#!/bin/sh

if xrandr -q | grep "VGA1 connected"; then
    xrandr --output LVDS1 --auto
    xrandr --output VGA1 --auto
    xset m 1 4
    pkill redshift
    redshift -x
else
    xrandr --output LVDS1 --auto
    xrandr --output VGA1 --off
    xset m default
    pkill redshift
    ~/bin/redshift.sh 
fi
