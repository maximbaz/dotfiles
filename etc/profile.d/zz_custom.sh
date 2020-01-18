#!/bin/sh

export EDITOR='kak'
export VISUAL='kak'
export DIFFPROG='meld'
export MANPAGER='kak-man-pager'
export WORDCHARS='*?_.[]~&!#$%^(){}<>'

# My own binaries
export PATH="$HOME/bin:$PATH"

# Use gpg-agent as ssh-agent
case "$(hostname)" in
    desktop-*) export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh" ;;
esac

export NNN_TRASH=1
export NNN_COLORS='4235'
export NNN_PLUG='j:jump;r:remove;c:croc;d:dragdrop;'
export NNN_BMS='d:~/Downloads;n:~/Downloads/nzbget/dst;'

export XSECURELOCK_FONT="-*-open sans-medium-r-*-*-30-*-*-*-*-*-*-uni"
export XSECURELOCK_SHOW_HOSTNAME=0
export XSECURELOCK_SHOW_USERNAME=0
export XSECURELOCK_WANT_FIRST_KEYPRESS=1
export XSECURELOCK_PASSWORD_PROMPT=time_hex

export PASSWORD_STORE_CHARACTER_SET='a-zA-Z0-9~!@#$%^&*()-_=+[]{};:,.<>?'
export PASSWORD_STORE_GENERATED_LENGTH=40

export FZ_CMD=j
export FZ_SUBDIR_CMD=jj

export LIBVA_DRIVER_NAME=iHD

export GOPATH="$HOME/.go"
