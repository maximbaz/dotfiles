. ~/.zsh-plugins/zsh-completions/zsh-completions.plugin.zsh

autoload -Uz compinit
compinit -i -d ${XDG_CACHE_HOME:-$HOME/.cache}/zcompcache-$ZSH_VERSION

autoload -Uz bashcompinit
bashcompinit

# General
zstyle ':completion:*'                  completer       _complete _match _approximate
zstyle ':completion:*:descriptions'     format          '[%d]'
zstyle ':completion:*:*:-subscript-:*'  tag-order       indexes parameters
zstyle ':completion:*'                  squeeze-slashes true
zstyle ':completion*'                   single-ignored  show
zstyle ':completion:*:(rm|kill|diff):*' ignore-line     other
zstyle ':completion:*:rm:*'             file-patterns   '*:all-files'
zstyle ':completion::complete:*'        use-cache       on
zstyle ':completion::complete:*'        cache-path      ${XDG_CACHE_HOME:-$HOME/.cache}/zcompcache-$ZSH_VERSION
zstyle ':completion:*:*:*:*:processes'  command         'ps -u $LOGNAME -o pid,user,command -w'
