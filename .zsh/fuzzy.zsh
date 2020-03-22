export FZF_COMPLETION_TRIGGER=''                         # ctrl-t goes to fzf whenever possible
export FZF_DEFAULT_OPTS='-m --reverse'

# Default file search commands
export FZF_DEFAULT_COMMAND='fd --hidden --follow --type=f'
_files() { compadd -f -- "$(fd --hidden --follow --type=f | fzf --height=75%)" }
_fzf_compgen_path() { fd --hidden --follow --type=f . "$1" }

# Default directory search commands
export FZF_ALT_C_COMMAND='fd --hidden --follow --type=d'
_cd() { compadd -f -- "$(fd --hidden --follow --type=d | fzf --height=75%)" }
_fzf_compgen_dir() { fd --hidden --follow --type=d . "$1" }

. /usr/share/fzf/completion.zsh                          # load fzf-completion
. /usr/share/fzf/key-bindings.zsh                        # load fzf-cd-widget
bindkey -r '^[c'                                         # remove unwanted binding

FZF_TAB_PREFIX=                                          # remove '·'
bindkey '\t' expand-or-complete                          # fzf-tab reads it during initialization

FZ_CMD=j
FZ_SUBDIR_CMD=jj

. ~/.zsh-plugins/z/z.sh
. ~/.zsh-plugins/fz/fz.plugin.zsh
. ~/.zsh-plugins/fzf-tab/fzf-tab.plugin.zsh
