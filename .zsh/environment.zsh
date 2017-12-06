export TERMINAL='alacritty'
export EDITOR='nvim'
export VISUAL='nvim'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export WORDCHARS='*?_.[]~&!#$%^(){}<>'

# Use gpg-agent as ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"

# FZ configuration
export FZ_CMD=j
export FZ_SUBDIR_CMD=jj

# Pass configuration
export PASSWORD_STORE_CHARACTER_SET='a-zA-Z0-9~!@#$%^&*()-_=+[]{};:,.<>?'
export PASSWORD_STORE_GENERATED_LENGTH=40

# Java configuration
if [[ "$(hostname)" == "crmdevvm-0037" ]]; then
  export JAVA_HOME="/usr/lib/jvm/java-8-oracle"
else
  export JAVA_HOME="/usr/lib/jvm/java-8-jdk"
fi
export PATH="$JAVA_HOME/bin:$PATH"

# Maven configuration
if [[ "$(hostname)" == "crmdevvm-0037" ]]; then
  export MAVEN_OPTS="-Xms1g -Xmx12g -XX:PermSize=1g"
else
  export MAVEN_OPTS="-Xms1g -Xmx4g -XX:PermSize=1g"
fi
export M3_HOME="/usr/share/maven3"
export PATH="$M3_HOME/bin:$PATH"

# Haskell configuration
export PATH="$HOME/.cabal/bin:$PATH"

# Ruby configuration
if hash ruby 2>/dev/null; then
  export GEM_HOME="$(ruby -e 'print Gem.user_dir')"
  export PATH="$GEM_HOME/bin:$PATH"
fi

# RVM configuration
sandbox_init_rvm() {
  if [ -f $HOME/.rvm/scripts/rvm ]; then
     source $HOME/.rvm/scripts/rvm
  fi
}
sandbox_hook rvm rvm
sandbox_hook rvm eyaml

# Go configuration
export GOPATH=/home/maximbaz/.go
export PATH="$GOPATH/bin:$PATH"

# NPM configuration
export PATH="$HOME/.node_modules/bin:$PATH"
