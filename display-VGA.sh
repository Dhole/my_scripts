#!/bin/sh

if xrandr -q | grep "VGA1 connected"; then
    xrandr --output LVDS1 --auto
    xrandr --output VGA1 --auto --above LVDS1
    pkill redshift
    ~/bin/wall.sh &
    ~/bin/redshift_2screen.sh &
fi
