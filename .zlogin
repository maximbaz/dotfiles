{
  ZCOMPDUMP="$HOME/.zcompdump"
  rm -f "$ZCOMPDUMP*"
  autoload -U compinit && compinit
  zcompile "$ZCOMPDUMP"
} &!

