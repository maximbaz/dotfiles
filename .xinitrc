#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
  xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
  xmodmap $sysmodmap
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# merge in user configs

if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
  xmodmap "$usermodmap"
fi


xrandr --dpi 192                      # Set High DPI
compton &                             # Enable composition
start-pulseaudio-x11 &                # Pulse audio daemon

numlockx &                            # Turn on NumLock
unclutter &                           # Hide mouse when using keyboard

copyq &                               # Clipboard manager
dropboxd &                            # Dropbox
feh --bg-fill ~/wallpaper.png &       # Set wallpaper
nm-applet &                           # Network Manager applet
pasystray &                           # PulseAudio manager (to select default sink)
pnmixer &                             # PulseAudio mixer (to adjust volume)
redshift-gtk &                        # Warm colors at night
shutter --min_at_startup &            # Screenshot manager
skype &                               # Skype
udiskie --smart-tray &                # Automatically mount usb drives
urxvt &                               # Terminal

exec i3                               # WM

