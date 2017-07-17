#!/usr/bin/env bash

display=$(xrandr --listactivemonitors | grep '0:' | grep -o '[^ ]*$')

if [ "$#" -eq 1 ]; then
  dpi="$1"
elif [[ "$display" == "eDP-1" ]]; then
  dpi=210
else
  dpi=192
fi

echo "Setting DPI=$dpi"

sed -i --follow-symlinks "s/\(xrandr --dpi\) [0-9]\+/\1 $dpi/" ~/.xinitrc
sed -i --follow-symlinks "s/\(Xft.dpi:\) [0-9]\+/\1 $dpi/" ~/.Xresources
sed -zi --follow-symlinks "s/\(dpi:\n\s*x:\) [0-9]\+\(\.0\n\s*y:\) [0-9]\+/\1 $dpi\2 $dpi/" ~/.config/alacritty/alacritty.yml
