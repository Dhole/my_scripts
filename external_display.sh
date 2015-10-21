#! /bin/bash

# Turn on/off external display through first argument

usage()
{
cat << EOF
usage: $0 on/clone/off
EOF
}

OPTION=$1

if [[ $# -lt 1 ]]
then
    usage
    exit
fi

if [[ $OPTION == "on" ]]
then
    echo "Enabling second display..."
    xrandr --output VGA1 --auto --right-of LVDS1
    xset m 1 4
    exit
fi

if [[ $OPTION == "clone" ]]
then
    echo "Cloning to second display..."
    xrandr --output VGA1 --auto
    xset m 1 4
    exit
fi

if [[ $OPTION == "off" ]]
then
    echo "Disabling second display..."
    xrandr --output VGA1 --off
    xset m default
    exit
 fi

usage
