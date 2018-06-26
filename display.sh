#!/bin/sh

#DISP1=eDP1
DISP1=LVDS1
DISP2=$1
MODE=$2

off_all() {
    xrandr --output DP1 --off
    xrandr --output DP2 --off
    xrandr --output HDMI1 --off
    #xrandr --output $DISP1 --auto
    xrandr --output $DISP1 --off
}

if [ "$DISP1" = "" ] || [ "$MODE" = "" ]
then
    echo "Usage: $0 {$DISP1|DP1|HDMI1} {single|movie|left|right|above|below|clone}"
    exit 1
fi

if xrandr -q | grep "$DISP2 connected"; then
    #redshift -x
    #pkill redshift
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
        #~/bin/redshift.sh &
        echo ""
    fi

    if [ "$DISP2" = "DP1" ] || [ "$DISP2" = "DP2" ]
    then
        # The logitech USB bluetooth dongle shows up as several devices...
        IDS=`xinput | grep "Logitech USB Receiver" | grep "pointer" | grep -o -P "(?<=id=)[0-9]*" | tr '\n' ' '`
        for id in $IDS
        do
            xinput set-prop $id "libinput Accel Speed" 1
        done
        IDS=`xinput | grep "USB Optical Mouse" | grep -o -P "(?<=id=)[0-9]*" | tr '\n' ' '`
        for id in $IDS
        do
            xinput set-prop $id "libinput Accel Speed" 1
        done
    fi

    ~/bin/wall.sh &
fi
