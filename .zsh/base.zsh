# 10 second wait if you do something that will delete everything.
setopt RM_STAR_WAIT

# Set LS colors
eval `dircolors ~/dircolors.256dark`

# Some environment variables
export EDITOR='vim'
export TERM=xterm-256color
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Better Up and Down keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Common PATH extensions
export PATH="$HOME/.cabal/bin:$PATH"
export PATH="$HOME/.rvm/bin:$PATH"
export PATH="$HOME/miniconda3/bin:$PATH"

