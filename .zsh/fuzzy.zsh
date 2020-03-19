FZF_COMPLETION_TRIGGER=''                                # ctrl-t goes to fzf whenever possible
fzf_default_completion=z4h-expand-or-complete-with-dots  # ctrl-t falls back to tab
. /usr/share/fzf/completion.zsh                          # load fzf-completion
. /usr/share/fzf/key-bindings.zsh                        # load fzf-cd-widget
bindkey -r '^[c'                                         # remove unwanted binding

FZF_TAB_PREFIX=                                          # remove '·'
FZF_TAB_SHOW_GROUP=brief                                 # show group headers only for duplicate options
FZF_TAB_SINGLE_GROUP=()                                  # no colors and no header for a single group
FZF_TAB_CONTINUOUS_TRIGGER='alt-enter'                   # alt-enter to accept and trigger another completion
bindkey '\t' expand-or-complete                          # fzf-tab reads it during initialization

. ~/.zsh-plugins/z/z.sh
. ~/.zsh-plugins/fz/fz.plugin.zsh
. ~/.zsh-plugins/fzf-tab/fzf-tab.plugin.zsh
