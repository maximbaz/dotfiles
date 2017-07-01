#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
  echo -e "Usage examples:\n$0 inc\n$0 dec" >&2
  exit 1
fi

printf -v current %.0f $(light)
if [ "$1" == "dec" ]; then
  if (( current <= 5 )); then
    increment=-1
  else
    increment=-5
  fi
else
  if (( current < 5 )); then
    increment=1
  else
    increment=5
  fi
fi

new=$(( current + increment ))
light -S $new

# Refresh py3status immediately
killall -USR1 py3status
