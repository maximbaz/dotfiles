zstyle    ':z4h:'                   auto-update            no
zstyle    ':z4h:*'                  channel                stable
zstyle    ':z4h:'                   cd-key                 alt
zstyle    ':z4h:autosuggestions'    forward-char           accept
zstyle    ':z4h:ssh:*'              ssh-command            command ssh
zstyle    ':z4h:ssh:*'              send-extra-files       '~/.zsh-aliases'
zstyle -e ':z4h:ssh:*'              retrieve-history       'reply=($ZDOTDIR/.zsh_history.${(%):-%m}:$z4h_ssh_host)'
zstyle    ':fzf-tab:*'              continuous-trigger     tab

z4h install romkatv/archive || return

z4h init || return

fpath+=($Z4H/romkatv/archive)
autoload -Uz archive lsarchive unarchive edit-command-line

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

command -v direnv &> /dev/null && eval "$(direnv hook zsh)"

setopt GLOB_DOTS

z4h source /etc/bash_completion.d/azure-cli
z4h source /usr/share/LS_COLORS/dircolors.sh
z4h source ~/.zsh-aliases
z4h source ~/.zshrc-private

return 0
