#!/bin/sh

gsimplecal &
sleep 0.05 # let the window open

screen_width=$(xrandr | grep current | sed -r 's/^.*current ([0-9]+).*/\1/')
x_pos=$(( screen_width - 620 ))
y_pos=37

i3-msg "[class=\"Gsimplecal\"] move absolute position $x_pos $y_pos"
