# Source default FZF aliases
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
  . /usr/share/fzf/key-bindings.zsh
fi

if [ -f /usr/share/fzf/completion.zsh ]; then
  . /usr/share/fzf/completion.zsh
fi

# Better FZF
export FZF_DEFAULT_OPTS="--history=$HOME/.fzf_history"
export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND_EXCLUSIONS=$(sed -e '/^$/,$d' ~/.agignore | while read -r line; do printf "-path '*/%s' -o " "${line:0:-1}"; done | sed 's/ -o $//')
export FZF_ALT_C_COMMAND="command find -L ~ \( $FZF_ALT_C_COMMAND_EXCLUSIONS \) -prune -o -type d -print 2> /dev/null | sed 1d"

_fzf_compgen_path() {
  ag -g "" "$1"
}

# Use Ctrl+T to complete with FZF
export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion
