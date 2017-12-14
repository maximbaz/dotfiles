# Commands to execute asynchronously once after a login
{
  dircolors -b /usr/share/LS_COLORS >! "$HOME/.dircolors.zsh"
} &!

# Load machine-specific initialization
if [[ "$HOST" =~ "desktop-" ]]; then
  source ~/.zsh/autorun-startx.zsh
fi
