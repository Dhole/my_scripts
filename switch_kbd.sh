#! /bin/sh

if [ "`setxkbmap -v | grep "pc+gb"`" = "" ]
then
  echo "Switching to gb keyboard"
  setxkbmap gb
else
  echo "Switching to es keyboard"
  setxkbmap es
fi
