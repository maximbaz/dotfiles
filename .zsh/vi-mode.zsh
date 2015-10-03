MODE_INDICATOR="%{$fg_bold[green]%} [% NORMAL]%  %{$reset_color%}"
export KEYTIMEOUT=1

autoload edit-command-line
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N edit-command-line
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -M vicmd v edit-command-line
bindkey -M vicmd s sudo-command-line
bindkey -M vicmd "^[[A" up-line-or-beginning-search
bindkey -M vicmd "^[[B" down-line-or-beginning-search

