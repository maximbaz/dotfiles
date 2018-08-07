#!/bin/sh

export EDITOR='kak'
export VISUAL='kak'
export DIFFPROG='nvim -d'
export MANPAGER='kak-man-pager'
export WORDCHARS='*?_.[]~&!#$%^(){}<>'

# Used by bash-language-server
export EXPLAINSHELL_ENDPOINT="http://localhost:5000"

# Keep py3status 'do_not_disturb' module in sync with i3 lock and restart
export PY3STATUS_DND_LOCK="$HOME/.cache/py3status_do_not_disturb.lock"

# rebuild-detector configuration
export REBUILD_DETECTOR_REPOS='maximbaz-aur'

# My own binaries
export PATH="$HOME/bin:$PATH"

# Use gpg-agent as ssh-agent
case "$(hostname)" in
    desktop-*) export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh" ;;
esac

# Pass configuration
export PASSWORD_STORE_CHARACTER_SET='a-zA-Z0-9~!@#$%^&*()-_=+[]{};:,.<>?'
export PASSWORD_STORE_GENERATED_LENGTH=40

# Java configuration
export JAVA_HOME="/usr/lib/jvm/java-8-jdk"

# FZ configuration
export FZ_CMD=j
export FZ_SUBDIR_CMD=jj

# Java configuration
export PATH="$JAVA_HOME/bin:$PATH"

# Android configuration
export ANDROID_SDK_ROOT="$HOME/.android/sdk"

# Haskell configuration
export PATH="$HOME/.cabal/bin:$PATH"

# Ruby configuration
if hash ruby 2>/dev/null; then
  export GEM_HOME="$(ruby -e 'print Gem.user_dir')"
  export PATH="$GEM_HOME/bin:$PATH"
fi

# Go configuration
export GOPATH="$HOME/.go"
export PATH="$GOPATH/bin:$PATH"

# NPM configuration
export PATH="$HOME/.node_modules/bin:$PATH"
