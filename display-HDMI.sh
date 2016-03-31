#!/bin/sh

if xrandr -q | grep "HDMI1 connected"; then
    xrandr --output LVDS1 --auto
    xrandr --output HDMI1 --auto --above LVDS1
    pkill redshift
    ~/bin/redshift_2screen.sh
else
    xrandr --output LVDS1 --auto
    xrandr --output HDMI1 --off
    pkill redshift
    ~/bin/redshift.sh 
fi
