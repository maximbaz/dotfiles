set-title-precmd() {
  printf "\e]2;%s\a" "${PWD/#$HOME/~}"
}

set-title-preexec() {
  printf "\e]2;%s\a" "$1"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd set-title-precmd
add-zsh-hook preexec set-title-preexec
