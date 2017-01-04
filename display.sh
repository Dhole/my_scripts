#!/bin/sh

DISP1=eDP1
DISP2=$1
MODE=$2

off_all() {
    xrandr --output DP1 --off
    xrandr --output HDMI1 --off
    #xrandr --output eDP1 --auto
    xrandr --output eDP1 --off
}

if [ "$DISP1" = "" ] || [ "$MODE" = "" ]
then
    echo "Usage: $0 {eDP1|DP1|HDMI1} {single|movie|left|right|above|below|clone}"
    exit 1
fi

if xrandr -q | grep "$DISP2 connected"; then
    redshift -x
    pkill redshift
    off_all
    if [ "$MODE" = "single" ]
    then
        xrandr --output $DISP2 --auto
        #xrandr --output $DISP1 --off
    elif [ "$MODE" = "movie" ]
    then
        xrandr --output $DISP2 --auto
        #xrandr --output $DISP1 --off
    elif [ "$MODE" = "left" ]
    then
        xrandr --output $DISP1 --auto
        xrandr --output $DISP2 --auto --left-of $DISP1
    elif [ "$MODE" = "right" ]
    then
        xrandr --output $DISP1 --auto
        xrandr --output $DISP2 --auto --right-of $DISP1
    elif [ "$MODE" = "above" ]
    then
        xrandr --output $DISP1 --auto
        xrandr --output $DISP2 --auto --above $DISP1
    elif [ "$MODE" = "below" ]
    then
        xrandr --output $DISP1 --auto
        xrandr --output $DISP2 --auto --below $DISP1
    elif [ "$MODE" = "clone" ]
    then
        xrandr --output $DISP1 --auto
        xrandr --output $DISP2 --auto
    else
        xrandr --output $DISP1 --auto
    fi

    if [ "$MODE" != "movie" ]
    then
        ~/bin/redshift.sh &
    fi

    if [ "$DISP2" = "DP1" ]
    then
        # The logitech USB bluetooth dongle shows up as several devices...
        IDS=`xinput | grep "Logitech USB Receiver" | grep "pointer" | grep -o -P "(?<=id=)[0-9]*" | tr '\n' ' '`
        for id in $IDS
        do
            xinput set-prop $id "libinput Accel Speed" 1
        done
    fi

    ~/bin/wall.sh &
fi
