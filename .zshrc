# Launch a tmux session
if [[ "$HOST" =~ "crmdevvm-" ]]; then
  source ~/.zsh/autorun-same-tmux.zsh
fi

# Lazy-loading
source ~/.zsh/sandboxd.zsh

# Load environment variables
source /usr/share/LS_COLORS/dircolors.sh

# Load terminal configuration
source ~/.zsh/title.zsh
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
source ~/.zsh/pacman.zsh
source ~/.zsh/kubectl.zsh
source ~/.zsh/git.zsh
source ~/.zsh/fzf.zsh
source ~/.zsh/ssh.zsh
source ~/.zsh/mse.zsh

# Load azure-cli completions
source /usr/bin/az.completion.sh >/dev/null
