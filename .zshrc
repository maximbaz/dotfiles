export ZSH=$HOME/.oh-my-zsh

plugins=(git sudo zsh-completions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

rm -f $HOME/.zcompdump
autoload -U compinit && compinit

# Load common configuration
source ~/.zsh/aliases.zsh
source ~/.zsh/base.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/wm-specific.zsh

# Load machine-specific configurations
if [[ "$HOST" == "maximbaz-x1" ]]; then
  source ~/.zsh/mse.zsh
fi

if [[ "$HOST" == "crmdevvm-0037" ]]; then
  source ~/.zsh/mse.zsh
  source ~/.zsh/autorun-tmux.zsh
fi

