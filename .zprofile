{
  ZCOMPDUMP="$HOME/.zcompdump"
  rm -f "$ZCOMPDUMP*"
  autoload -U compinit && compinit
  zcompile "$ZCOMPDUMP"

  kubectl completion zsh >! "$HOME/.zsh.kubectl.completion"
} &!

# Load machine-specific initialization
if [[ "$(hostname)" == "maximbaz-x1" ]]; then
  source ~/.zsh/autorun-startx.zsh
fi
