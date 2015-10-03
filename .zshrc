export ZSH=$HOME/.oh-my-zsh

plugins=(git sudo cd-gitroot pantheon-terminal-notify vi-mode zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Load common configuration
source ~/.zsh/aliases.zsh
source ~/.zsh/base.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/vi-mode.zsh

# Load machine-specific configurations
if [[ "$HOST" == "z0rch-x1" || "$HOST" == "crmdevvm-0041" ]]; then
  source ~/.zsh/mse.zsh
fi

