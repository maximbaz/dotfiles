#!/bin/sh

export EDITOR='kak'
export VISUAL='kak'
export DIFFPROG='meld'
export MANPAGER='kak-man-pager'
export AUR_PAGER='nnn -Aer'
export WORDCHARS='*?_.[]~&!#$%^(){}<>'

export PATH="$HOME/bin:$PATH:/usr/share/sway/scripts/"

# Use gpg-agent as ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"

export NNN_TRASH=1
export NNN_COLORS='4235'
export NNN_PLUG='j:jump;r:remove;c:croc;d:dragdrop;'
export NNN_BMS='d:~/Downloads;n:/home/nzbget/dst;N:/home/nzbget/nzb;r:/run/media/maximbaz;'

export XSECURELOCK_FONT="-*-open sans-medium-r-*-*-30-*-*-*-*-*-*-uni"
export XSECURELOCK_SHOW_HOSTNAME=0
export XSECURELOCK_SHOW_USERNAME=0
export XSECURELOCK_WANT_FIRST_KEYPRESS=1
export XSECURELOCK_PASSWORD_PROMPT=time_hex

export PASSWORD_STORE_CHARACTER_SET='a-zA-Z0-9~!@#$%^&*()-_=+[]{};:,.<>?'
export PASSWORD_STORE_GENERATED_LENGTH=40

export LIBVA_DRIVER_NAME=iHD

export GOPATH="$HOME/.go"
export GOPRIVATE="bitbucket.org/maersk-analytics"

export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland-egl
export QT_WAYLAND_FORCE_DPI=physical
