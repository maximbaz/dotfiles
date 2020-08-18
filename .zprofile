#!/usr/bin/env zsh

export $(systemctl --user show-environment)

if [[ -z $DISPLAY && "$(tty)" == "/dev/tty1" ]]; then
    systemd-cat -t sway sway
    systemctl --user stop sway-session.target
    systemctl --user unset-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
fi
