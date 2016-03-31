#!/bin/sh

if xrandr -q | grep "HDMI1 connected"; then
    xrandr --output HDMI1 --auto
    xrandr --output LVDS1 --off
    pkill redshift
    redshift -x
else
    xrandr --output LVDS1 --auto
    xrandr --output HDMI1 --off
    pkill redshift
    ~/bin/redshift.sh 
fi
