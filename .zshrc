# Launch a tmux session
if [[ "$HOST" =~ "desktop-" ]]; then
  source ~/.zsh/autorun-tmux.zsh
elif [[ "$HOST" =~ "crmdevvm-" ]]; then
  source ~/.zsh/autorun-same-tmux.zsh
fi

# Lazy-loading functionality
source ~/.zsh/sandboxd.zsh

# Load environment variables
source ~/.zsh/environment.zsh
source ~/.dircolors.zsh

# Load prompt configuration
source ~/.zsh/prompt.zsh

# Load plugins
source ~/.zsh/prezto.zsh
source ~/.zsh/zsh-notify.zsh
source ~/.zsh/antigen.zsh
source ~/.zsh/prezto-patches.zsh

# Load custom configurations
source ~/.zsh/opts.zsh
source ~/.zsh/keybindings.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/git.zsh
source ~/.zsh/fzf.zsh
source ~/.zsh/ssh.zsh
source ~/.zsh/mse.zsh
