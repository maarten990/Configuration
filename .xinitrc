#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# set some X stuff
xset +fp /usr/share/fonts/local && xset fp rehash
xset +dpms
xset dpms 0 0 300
xset r rate 250 25
xset m 0 0

xsetroot -bg black
xsetroot -cursor_name left_ptr
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &
xrdb ~/.Xresources

# wallpaper
feh --bg-scale ~/Dropbox/Pictures/greenblue.jpg

# system tray
if [ "$1" = xmonad ]; then
  trayer --edge top --align right --widthtype pixel --width 100 --height 20 --tint 0x151515 --transparent true --alpha 0 &
  nm-applet &
  xfce4-power-manager &
  volumeicon &
fi

exec $1
