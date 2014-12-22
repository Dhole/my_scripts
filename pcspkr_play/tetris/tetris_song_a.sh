#!/bin/bash

# Play notes1 (Tetris song A) on PC Speaker

modprobe pcspkr

while read line
do  
  beep -f $(( ${line%% *} * 2 )) -l $(( ${line#* } * 150 ))
  sleep 0.01
done < "notes1"

