#!/bin/sh

lock() {
  setxkbmap -layout "us"
  i3lock -f -l
}

case "$1" in
  lock)
    lock
    ;;
  logout)
    i3-msg exit
    ;;
  suspend)
    lock && dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.Suspend" boolean:true
    ;;
  reboot)
    dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.Reboot" boolean:true
    ;;
  shutdown)
    dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.PowerOff" boolean:true
    ;;
  *)
    echo "Usage: $0 {lock|logout|suspend|reboot|shutdown}"
    exit 2
esac

exit 0
