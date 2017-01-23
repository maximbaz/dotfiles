# Workaround for previewing imagines in ranger
# https://bugs.launchpad.net/sakura/+bug/1625614
export WINDOWID=$(($WINDOWID))


source "$HOME/.zprezto/init.zsh"

# Define a better hotkey to edit command in editor
bindkey -M emacs "$key_info[Control]V$key_info[Control]V" edit-command-line

# Load generic configurations
source ~/.zsh/aliases.base.zsh
source ~/.zsh/aliases.git.zsh

# Load machine-specific configurations
if [[ "$(hostname)" == "maximbaz-x1" ]]; then
  source ~/.zsh/mse.zsh
  source ~/.zsh/autorun-tmux.zsh
fi

if [[ "$(hostname)" == "crmdevvm-0037" ]]; then
  source ~/.zsh/mse.zsh
  source ~/.zsh/autorun-same-tmux.zsh
fi

