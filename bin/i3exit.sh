#!/usr/bin/env zsh

before_lock() {
  ~/bin/change-keyboard-layout.sh reset
  killall -u "$USER" -USR1 dunst
  killall compton
}

lock() {
  i3lock -efnc 000000
}

after_lock() {
  compton &!
  killall -u "$USER" -USR2 dunst
}

case "$1" in
  lock)
    before_lock
    lock
    after_lock
    ;;
  logout)
    i3-msg exit
    ;;
  suspend)
    before_lock
    systemctl suspend
    lock
    after_lock
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
