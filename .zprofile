#!/usr/bin/env zsh

export LANG=en_US.UTF-8
export LANGUAGE=en_US
export LC_MONETARY=en_DK.UTF-8
export LC_TIME=en_DK.UTF-8

export LIBVA_DRIVER_NAME=iHD
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"

export MOZ_ENABLE_WAYLAND=1
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export QT_QPA_PLATFORM=wayland-egl
export WLR_DRM_NO_MODIFIERS=1

export PATH="$HOME/bin:$PATH:/usr/share/sway/scripts/"

[[ -z $DISPLAY && "$(tty)" == "/dev/tty1" ]] && systemd-cat -t sway sway
