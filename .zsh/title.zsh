function set-title-precmd() {
  [[ "$TERM" == "xterm-kitty" ]] && kitty @ set-window-title "${PWD/#$HOME/~}"
}

function set-title-preexec() {
  [[ "$TERM" == "xterm-kitty" ]] && kitty @ set-window-title "$1"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd set-title-precmd
add-zsh-hook preexec set-title-preexec
