#!/usr/bin/env zsh

command -v kak  &> /dev/null && export EDITOR='kak'     || export EDITOR='vim'
command -v kak  &> /dev/null && export VISUAL='kak'     || export VISUAL='vim'
command -v meld &> /dev/null && export DIFFPROG='meld'
command -v kak  &> /dev/null && export MANPAGER='kak-man-pager'

export AUR_PAGER='aurutils-nnn'
export DIRENV_LOG_FORMAT=
export FZF_DEFAULT_OPTS='-m --reverse'
export GPG_TTY=$TTY
export SYSTEMD_LESS=FRXMK

export GOPATH="$HOME/.go"
export GOPRIVATE="bitbucket.org/maersk-analytics"

export NNN_TRASH=1
export NNN_COLORS='4235'
export NNN_PLUG='j:jump;r:remove;c:croc;d:dragdrop;'
export NNN_BMS='d:~/Downloads;n:/home/nzbget/dst;N:/home/nzbget/nzb;r:/run/media/maximbaz;'
export NNN_OPTS='Aer'

export PASSWORD_STORE_CHARACTER_SET='a-zA-Z0-9~!@#$%^&*()-_=+[]{};:,.<>?'
export PASSWORD_STORE_GENERATED_LENGTH=40

if [ -n "${ZSH_VERSION-}" ]; then
    : ${ZDOTDIR:=~}
    setopt no_global_rcs
    if [[ -o no_interactive && -z "${Z4H_BOOTSTRAPPING-}" ]]; then
        return
    fi
    setopt no_rcs
    unset Z4H_BOOTSTRAPPING
fi

Z4H_URL="https://raw.githubusercontent.com/romkatv/zsh4humans/v3"
: "${Z4H:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh4humans}"

umask o-w

if [ ! -e "$Z4H"/z4h.zsh ]; then
    mkdir -p -- "$Z4H" || return
    printf >&2 '\033[33mz4h\033[0m: fetching \033[4mz4h.zsh\033[0m\n'
    if command -v curl > /dev/null 2>&1; then
        curl -fsSL -- "$Z4H_URL"/z4h.zsh > "$Z4H"/z4h.zsh.$$ || return
    elif command -v wget > /dev/null 2>&1; then
        wget -O- -- "$Z4H_URL"/z4h.zsh > "$Z4H"/z4h.zsh.$$ || return
    else
        printf >&2 '\033[33mz4h\033[0m: please install \033[32mcurl\033[0m or \033[32mwget\033[0m\n'
        return 1
    fi
    mv -- "$Z4H"/z4h.zsh.$$ "$Z4H"/z4h.zsh || return
fi

. "$Z4H"/z4h.zsh || return

setopt rcs
