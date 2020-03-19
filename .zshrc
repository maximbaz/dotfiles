if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

. ~/.zsh/title.zsh
. ~/.zsh/fuzzy.zsh
. ~/.zsh/completion.zsh
. ~/.zsh/environment.zsh

. ~/.zsh/archive.zsh
. ~/.zsh/aliases.zsh
. ~/.zsh/pacman.zsh
. ~/.zsh/kubectl.zsh
. ~/.zsh/git.zsh

. ~/.zsh/widgets.zsh
. ~/.zsh/tools.zsh

[ -f ~/.zshrc-private ] && . ~/.zshrc-private

. ~/.zsh/p10k.zsh
. ~/.zsh-plugins/powerlevel10k/powerlevel10k.zsh-theme
. ~/.zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
. ~/.zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
. ~/.zsh-plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh

. ~/.zsh/keybindings.zsh
. ~/.zsh/opts.zsh
