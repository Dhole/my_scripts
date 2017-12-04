#! /bin/sh

## Reset mappings
#setxkbmap -option
## Swap left-win and left-ctrl
#setxkbmap -option ctrl:swap_lwin_lctl
## Map ctrl to CapsLock
#setxkbmap -option ctrl:nocaps
## Map compose to right-ctrl AltGr
#setxkbmap -option compose:rctrl-altgr
## to reset the xkbmap: `setxkbmap -option`

# New version
setxkbmap -option
setxkbmap -layout us
xmodmap ~/.Xmodmap
