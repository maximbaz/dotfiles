[[ -z $DISPLAY && "$(tty)" == "/dev/tty1" ]] && exec startx
[[ -z $DISPLAY && "$(tty)" == "/dev/tty2" ]] && exec sway
