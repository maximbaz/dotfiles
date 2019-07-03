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

export XSECURELOCK_FONT="-*-open sans-medium-r-*-*-30-*-*-*-*-*-*-uni"
export XSECURELOCK_SHOW_HOSTNAME=0
export XSECURELOCK_SHOW_USERNAME=0
export XSECURELOCK_WANT_FIRST_KEYPRESS=1
export XSECURELOCK_PASSWORD_PROMPT=time_hex

export PASSWORD_STORE_CHARACTER_SET='a-zA-Z0-9~!@#$%^&*()-_=+[]{};:,.<>?'
export PASSWORD_STORE_GENERATED_LENGTH=40

export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"
export PATH="$JAVA_HOME/bin:$PATH"

export FZ_CMD=j
export FZ_SUBDIR_CMD=jj

export ANDROID_SDK_ROOT="$HOME/.android/sdk"

export WEECHAT_HOME="$HOME/.config/weechat"

export PATH="$HOME/.cabal/bin:$PATH"

if hash ruby 2>/dev/null; then
  export GEM_HOME="$(ruby -e 'print Gem.user_dir')"
  export PATH="$GEM_HOME/bin:$PATH"
fi

export GOPATH="$HOME/.go"
export PATH="$GOPATH/bin:$PATH"

export PATH="$HOME/.node_modules/bin:$PATH"
