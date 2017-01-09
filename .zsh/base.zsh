# Set LS colors
eval `dircolors ~/dircolors.256dark`

# Some environment variables
export VISUAL='nvim'
export EDITOR='nvim'
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export XDG_CONFIG_HOME="$HOME/.config"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Better Up and Down keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search

# Edit command in vim
autoload edit-command-line
zle -N edit-command-line
bindkey "^X^V" edit-command-line

# Toggle sudo
bindkey "^X^S" sudo-command-line

# Better FZF
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore .cache --ignore .npm --ignore .gem --ignore .local -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="command find -L . -fstype 'dev' -o -fstype 'proc' -prune -o -path '*/\\.git' -prune -o -type d -print 2> /dev/null | sed 1d | cut -b3-"

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
export PATH="$M2_HOME/bin:$PATH"

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
export GEM_HOME="$(ruby -e 'print Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"

# Go configuration
export GOPATH=/home/maximbaz/.golang
export PATH="$PATH:$GOPATH/bin"

