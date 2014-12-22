#! /bin/bash

# Convert a gif into webm, with specified speed

INPUT=$1
OUTPUT=$2
SPEED=$3

mplayer -vo jpeg $INPUT
ffmpeg -r $SPEED -i %08d.jpg -r 23 -y -an $OUTPUT
rm *.jpg
