zstyle ':z4h:' auto-update no
zstyle ':z4h:*' channel stable
zstyle ':z4h:' cd-key alt
zstyle ':z4h:autosuggestions' forward-char accept

z4h install romkatv/archive || return

z4h init || return

fpath+=($Z4H/romkatv/archive)
autoload -Uz archive lsarchive unarchive edit-command-line

zstyle ':fzf-tab:*' continuous-trigger tab

my-ctrl-z() {
    if [[ $#BUFFER -eq 0 ]]; then
        BUFFER="fg"
        zle accept-line -w
    else
        zle push-input -w
        zle clear-screen -w
    fi
}
zle -N my-ctrl-z
bindkey '^Z' my-ctrl-z

zle -N edit-command-line
bindkey '^V^V' edit-command-line

export DIRENV_LOG_FORMAT=
eval "$(direnv hook zsh)"

setopt GLOB_DOTS

z4h source /usr/share/LS_COLORS/dircolors.sh
z4h source /etc/bash_completion.d/azure-cli
z4h source ~/.zsh/aliases.zsh
z4h source ~/.zsh/git.zsh
z4h source ~/.zsh/pacman.zsh
z4h source ~/.zsh/kubectl.zsh
z4h source ~/.zshrc-private

return 0
