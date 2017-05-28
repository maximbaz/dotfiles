export EDITOR='nvim'
export VISUAL='nvim'
export XDG_CONFIG_HOME="$HOME/.config"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set chars treated as part of a word
export WORDCHARS='*?.[]~&!#$%^(){}<>'

# NeoVim configuration
export NVIM_TUI_ENABLE_TRUE_COLOR=1

# FZ configuration
export FZ_CMD=j
export FZ_SUBDIR_CMD=jj

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

# Gradle configuration
export GRADLE_HOME="$HOME/gradle-2.4"
export PATH="$GRADLE_HOME/bin:$PATH"

# Jetty configuration
export JETTY_HOME="$HOME/jetty-9.2"
export PATH="$JETTY_HOME/bin:$PATH"

# Haskell configuration
export PATH="$HOME/.cabal/bin:$PATH"

# Ruby configuration
if [ -f $HOME/.rvm/scripts/rvm ]; then
  source $HOME/.rvm/scripts/rvm
fi
if hash ruby 2>/dev/null; then
  export GEM_HOME="$(ruby -e 'print Gem.user_dir')"
  export PATH="$PATH:$GEM_HOME/bin"
fi

# Go configuration
export GOPATH=/home/maximbaz/.go
export PATH="$PATH:$GOPATH/bin"
