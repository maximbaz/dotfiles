export TERMINAL='kitty'
export EDITOR='nvim'
export VISUAL='nvim'
export DIFFPROG='nvim -d'
export MANPAGER="nvim -c 'set ft=man' -"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export WORDCHARS='*?_.[]~&!#$%^(){}<>'

# Keep py3status 'do_not_disturb' module in sync with i3 lock and restart
export PY3STATUS_DND_LOCK="$HOME/.cache/py3status_do_not_disturb.lock"

# My own binaries
export PATH="$HOME/bin:$PATH"

# Use gpg-agent as ssh-agent
if [[ "$HOST" =~ "desktop-" ]]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"
fi

# FZ configuration
export FZ_CMD=j
export FZ_SUBDIR_CMD=jj

# Pass configuration
export PASSWORD_STORE_CHARACTER_SET='a-zA-Z0-9~!@#$%^&*()-_=+[]{};:,.<>?'
export PASSWORD_STORE_GENERATED_LENGTH=40

# Java configuration
export JAVA_HOME="/usr/lib/jvm/java-8-jdk"
export PATH="$JAVA_HOME/bin:$PATH"

# Maven configuration
export MAVEN_OPTS="-Xms1g -Xmx12g -XX:PermSize=1g"
export M3_HOME="/usr/share/maven3"
export PATH="$M3_HOME/bin:$PATH"

# Android configuration
export ANDROID_SDK_ROOT="$HOME/.android/sdk"

# Haskell configuration
export PATH="$HOME/.cabal/bin:$PATH"

# Ruby configuration
if hash ruby 2>/dev/null; then
  export GEM_HOME="$(ruby -e 'print Gem.user_dir')"
  export PATH="$GEM_HOME/bin:$PATH"
fi

# RVM configuration
sandbox_init_rvm() {
  if [ -f /usr/share/rvm/scripts/rvm ]; then
     source /usr/share/rvm/scripts/rvm
  fi
}
sandbox_hook rvm rvm
sandbox_hook rvm eyaml

# Go configuration
export GOPATH=/home/maximbaz/.go
export PATH="$GOPATH/bin:$PATH"

# NPM configuration
export PATH="$HOME/.node_modules/bin:$PATH"
