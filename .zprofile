# Commands to execute asynchronously once after a login
{
  dircolors -b /usr/share/LS_COLORS >! "$HOME/.dircolors.zsh"
} &!
