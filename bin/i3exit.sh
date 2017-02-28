#!/bin/sh

lock() {
  ~/bin/change-keyboard-layout.sh reset
  killall -u "$USER" -USR1 dunst
  i3lock -e -f -n -c 000000
  killall -u "$USER" -USR2 dunst
}

case "$1" in
  lock)
    lock
    ;;
  logout)
    i3-msg exit
    ;;
  suspend)
    systemctl suspend; lock
    ;;
  reboot)
    systemctl reboot
    ;;
  shutdown)
    systemctl poweroff
    ;;
  *)
    echo "Usage: $0 {lock|logout|suspend|reboot|shutdown}"
    exit 2
esac

exit 0
