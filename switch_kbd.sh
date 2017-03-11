#! /bin/sh

export DISPLAY=:0.0

#nocaps() {
#  setxkbmap -option ctrl:nocaps
#  setxkbmap -option compose:caps
#}

if [ "`setxkbmap -v | grep "pc+us"`" = "" ]
then
  echo "Switching to us keyboard"
  setxkbmap us
  ~/bin/keyboard.sh
  #nocaps
else
  echo "Switching to es keyboard"
  setxkbmap es
  ~/bin/keyboard.sh
  #nocaps
fi
