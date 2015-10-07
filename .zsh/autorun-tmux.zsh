if [[ -z "$TMUX" ]]; then
  tmux has-session &> /dev/null
  if [ $? -eq 1 ]; then
    exec tmux new
  else
    exec tmux attach
  fi
  exit
fi
