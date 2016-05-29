#!/bin/sh

lock() {
  ~/bin/change-keyboard-layout.sh reset
  i3lock -f -c 000000
}

case "$1" in
  lock)
    lock
    ;;
  logout)
    killall albert; i3-msg exit
    ;;
  suspend)
    lock && systemctl suspend
    ;;
  reboot)
    killall albert; systemctl reboot
    ;;
  shutdown)
    killall albert; systemctl poweroff
    ;;
  *)
    echo "Usage: $0 {lock|logout|suspend|reboot|shutdown}"
    exit 2
esac

exit 0
