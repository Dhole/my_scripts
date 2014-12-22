#!/bin/bash

# Play notes2 (Tetris song B) on PC Speaker

modprobe pcspkr

while read line
do  
  beep -f ${line%% *} -l $(( ${line#* } * 150 ))
  sleep 0.01
done < "notes2"

