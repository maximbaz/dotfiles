#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
  echo -e "Usage examples:\n$0 +5\n$0 -5\n$0 mute" >&2
  exit 1
fi

case "$1" in
  mute)
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    ;;
  *)
    current=$(pamixer --sink @DEFAULT_SINK@ --get-volume)
    new=$(( current + $1 ))
    if (( current >= 120 && new > current )); then
      echo "Cannot set volume higher than 120%" >&2
      exit 2
    fi
    if (( new > 120 )); then
      new=120
    fi
    pactl set-sink-volume @DEFAULT_SINK@ $new%
    ;;
esac

killall -s USR1 py3status
