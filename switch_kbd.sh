#! /bin/sh

export DISPLAY=:0.0

nocaps() {
  setxkbmap -option ctrl:nocaps
  setxkbmap -option compose:caps
}

if [ "`setxkbmap -v | grep "pc+gb"`" = "" ]
then
  echo "Switching to gb keyboard"
  setxkbmap gb
  nocaps
else
  echo "Switching to es keyboard"
  setxkbmap es
  nocaps
fi
