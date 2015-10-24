#!/bin/sh

while true
do
  ps -C gsimplecal > /dev/null
  if [[ $? == 0 && "gsimplecal" != `xdotool getwindowfocus getwindowname` ]]; then
    killall gsimplecal
  fi
  sleep 0.2s
done
