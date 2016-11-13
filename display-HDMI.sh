#!/bin/sh

if xrandr -q | grep "HDMI-1 connected"; then
    xrandr --output LVDS-1 --auto
    xrandr --output HDMI-1 --auto --above LVDS-1
    pkill redshift
    ~/bin/redshift_2screen.sh
fi
