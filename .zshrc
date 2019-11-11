if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

(( EUID )) && for f in ~/.zshrc ~/.zsh/*.zsh; do [[ ! -s $f.zwc || $f -nt $f.zwc ]] && zcompile $f; done

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

# Make Ctrl-D work with p10k instant prompt
function my-ctrl-d() {
    zle || exit 0
    [[ -n $BUFFER ]] && return
    typeset -g precmd_functions=(my-ctrl-d)
    zle accept-line
}
zle -N my-ctrl-d
bindkey '^D' my-ctrl-d
setopt ignore_eof
