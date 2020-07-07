export LANG=en_US.UTF-8
export LANGUAGE=en_US
export LC_MONETARY=en_DK.UTF-8
export LC_TIME=en_DK.UTF-8

export EDITOR='kak'
export VISUAL='kak'
export DIFFPROG='meld'
export MANPAGER='kak-man-pager'
export AUR_PAGER='aurutils-nnn'

export WORDCHARS='*?_.[]~&!#$%^(){}<>'

export DIRENV_LOG_FORMAT=

export GPG_TTY=$TTY
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"

export PASSWORD_STORE_CHARACTER_SET='a-zA-Z0-9~!@#$%^&*()-_=+[]{};:,.<>?'
export PASSWORD_STORE_GENERATED_LENGTH=40

export GOPATH="$HOME/.go"
export GOPRIVATE="bitbucket.org/maersk-analytics"

export NNN_TRASH=1
export NNN_COLORS='4235'
export NNN_PLUG='j:jump;r:remove;c:croc;d:dragdrop;'
export NNN_BMS='d:~/Downloads;n:/home/nzbget/dst;N:/home/nzbget/nzb;r:/run/media/maximbaz;'
export NNN_OPTS='Aer'

export FZF_DEFAULT_OPTS='-m --reverse'

export LIBVA_DRIVER_NAME=iHD

export MOZ_ENABLE_WAYLAND=1
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export QT_QPA_PLATFORM=wayland-egl
export WLR_DRM_NO_MODIFIERS=1

export PATH="$HOME/bin:$PATH:/usr/share/sway/scripts/"


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
  >&2 printf '\033[33mz4h\033[0m: fetching \033[4mz4h.zsh\033[0m\n'
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL -- "$Z4H_URL"/z4h.zsh >"$Z4H"/z4h.zsh.$$  || return
  elif command -v wget >/dev/null 2>&1; then
    wget -O-   -- "$Z4H_URL"/z4h.zsh >"$Z4H"/z4h.zsh.$$  || return
  else
    >&2 printf '\033[33mz4h\033[0m: please install \033[32mcurl\033[0m or \033[32mwget\033[0m\n'
    return 1
  fi
  mv -- "$Z4H"/z4h.zsh.$$ "$Z4H"/z4h.zsh || return
fi

. "$Z4H"/z4h.zsh || return

setopt rcs
