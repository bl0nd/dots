#!/bin/sh

# Start Xresources on login
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Prevent Display Sleep
xset -dpms
xset s off

# Caps Lock
# set these with localectl and a personal keymap
xmodmap -e "clear lock"
xmodmap -e "keycode 66 = Escape"

# Keyboard
xset r rate 250 30

# Wallpaper
sh ~/.fehbg

# Disable middle click because screw the middle click
# This messes up touchpad scroll
# xmodmap -e "pointer = 1 0 3 4 5"

# Compton
[[ "$(pgrep compton)" ]] || compton --config ~/.config/compton.conf -b

# Urxvtd
urxvtd -q -o -f

exec i3
