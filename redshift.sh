#!/bin/sh

set -x

# disable with redshift -x

#Spain
#LOC=40.4163798:-3.6967864
# Germany
#LOC=52:13
# CA
LOC=35:-115

export DISPLAY=:0.0

_sleep() {
    perl -e "use Time::HiRes; Time::HiRes::sleep(${1});"
}

_wait() {
    while kill -0 ${1} 2> /dev/null; do _sleep 0.1; done;
}

on() {
    #redshift-gtk -o -l ${LOC}
    redshift-gtk -l ${LOC} &
}

off() {
    REDSHIFT_PATH=`which redshift` 
    REDSHIFT_PID=`pgrep -f "${REDSHIFT_PATH} "`
    REDSHIFTGTK_PID=`pgrep redshift-gtk`

    kill ${REDSHIFTGTK_PID}
    kill ${REDSHIFT_PID}
    _wait ${REDSHIFTGTK_PID}
    _wait ${REDSHIFT_PID}

    redshift -x
}


case "$1" in
    off)
        off
        ;;
    toggle)
        pgrep 'redshift$' > /dev/null
        if [ $? -eq 0 ]; then
            off
        else
            on
        fi
        ;;
    *)
        on
        ;;
esac
