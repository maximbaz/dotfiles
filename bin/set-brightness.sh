#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
  echo -e "Usage examples:\n$0 inc\n$0 dec\n$0 bat\n$0 ac" >&2
  exit 1
fi

# Restore last brightness value for battery or AC
if [[ "$1" == "bat" || "$1" == "ac" ]]; then
  light -S $(< /home/maximbaz/.brightness_$1)
  killall -USR1 py3status
  exit 0
fi

# Increase or decrease current brightness value
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
killall -USR1 py3status

# Save brightness value to a file
battery_status=$(acpi | grep -Po '(?<=: )\w+')
if [[ "$battery_status" == "Discharging" ]]; then
  power="bat"
else
  power="ac"
fi
echo "$new" > /home/maximbaz/.brightness_$power
