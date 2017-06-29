{
  ZCOMPDUMP="$HOME/.zcompdump"
  rm -f "$ZCOMPDUMP*"
  autoload -U compinit && compinit
  zcompile "$ZCOMPDUMP"
} &!

# Load machine-specific initialization
if [[ "$(hostname)" =~ "desktop-" ]]; then
  source ~/.zsh/autorun-startx.zsh
fi
