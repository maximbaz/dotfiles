alias ssh='ssh_with_color_and_term'

ssh_with_color_and_term() {
  trap 'bg_color_reset' SIGINT
  bg_color_set "$@"
  printf '\033]2;%s\033\\' "$@"
  kitty +kitten ssh "$@"
  retval=$?
  bg_color_reset
  return $retval
}
compdef "_dispatch ssh ssh" ssh_with_color_and_term

bg_color_reset() {
  printf '\033]11;#282828\007'
  trap - SIGINT
}

bg_color_set() {
  color='#282828'
  for arg in "$@"; do
    if [[ "${arg:0:1}" != "-" ]]; then
      if [[ "$arg" =~ '^prod[0-9]?-' ]]; then
        color='#322828'
      elif [[ "$arg" =~ '^int[0-9]?-' ]]; then
        color='#323228'
      fi
    fi
  done
  printf "\033]11;$color\007"
}
