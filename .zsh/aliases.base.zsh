alias plz='sudo $(fc -ln -1)'
alias psg='ps aux | grep '
alias rm='nocorrect rm -rf'
alias sudo='sudo -E'
alias vi='nvim'
alias vim='nvim'


# FZF aliases
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
  . /usr/share/fzf/key-bindings.zsh
fi

if [ -f /usr/share/fzf/completion.zsh ]; then
  . /usr/share/fzf/completion.zsh
fi

