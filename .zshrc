# Launch a tmux session
if [[ "$HOST" =~ "crmdevvm-" ]]; then
  . ~/.zsh/autorun-same-tmux.zsh
fi

# Lazy-loading
. ~/.zsh/sandboxd.zsh

# Load environment variables
. /usr/share/LS_COLORS/dircolors.sh

# Load terminal configuration
. ~/.zsh/title.zsh
. ~/.zsh/prompt.zsh
. ~/.zsh/p10k-transient.zsh

# Load plugins
. ~/.zsh/prezto.zsh
. ~/.zsh/zsh-notify.zsh
. ~/.zsh/antigen.zsh
. ~/.zsh/prezto-patches.zsh

# Load custom configurations
. ~/.zsh/opts.zsh
. ~/.zsh/keybindings.zsh
. ~/.zsh/aliases.zsh
. ~/.zsh/pacman.zsh
. ~/.zsh/kubectl.zsh
. ~/.zsh/git.zsh
. ~/.zsh/fuzzy.zsh
. ~/.zsh/ssh.zsh
. ~/.zsh/mse.zsh

# Load azure-cli completions
export PATH="$PATH:$HOME/lib/azure-cli/bin"
. az.completion.sh >/dev/null
