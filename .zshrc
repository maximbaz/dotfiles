# Initial configuration
source /etc/zsh/zprofile

# Lazy-loading functionality
source ~/.zsh/sandboxd.zsh

# Load environment variables
source ~/.zsh/environment.zsh
source ~/.dircolors.zsh

# Load plugins
source ~/.zsh/antigen.zsh

# Load custom configurations
source ~/.zsh/aliases.zsh
source ~/.zsh/fzf.zsh
source ~/.zsh/git.zsh
source ~/.zsh/ssh.zsh
source ~/.zsh/pacman.zsh
source ~/.zsh/mse.zsh

# Load machine-specific configurations
if [[ "$HOST" =~ "desktop-" ]]; then
  source ~/.zsh/autorun-tmux.zsh
elif [[ "$HOST" == "crmdevvm-0037" ]]; then
  source ~/.zsh/autorun-same-tmux.zsh
fi
