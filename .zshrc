zstyle    ':z4h:'                                        auto-update            no
zstyle    ':z4h:*'                                       channel                stable
zstyle    ':z4h:autosuggestions'                         forward-char           accept
zstyle    ':z4h:ssh:*'                                   ssh-command            command ssh
zstyle    ':z4h:ssh:*'                                   send-extra-files       '~/.zsh-aliases'
zstyle    ':z4h:ssh:router'                              passthrough            yes
zstyle    ':fzf-tab:*'                                   continuous-trigger     tab
zstyle    ':zle:(up|down)-line-or-beginning-search'      leave-cursor           no
zstyle    ':z4h:term-title:ssh'                          preexec                '%* | %n@%m: ${1//\%/%%}'
zstyle    ':z4h:term-title:local'                        preexec                '%* | ${1//\%/%%}'
zstyle    ':zle:up-line-or-beginning-search'             leave-cursor           true
zstyle    ':zle:down-line-or-beginning-search'           leave-cursor           true

###

z4h install romkatv/archive || return
z4h init || return

####

fpath+=($Z4H/romkatv/archive)
autoload -Uz archive lsarchive unarchive edit-command-line

zle -N edit-command-line

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

toggle-sudo() {
    [[ -z "$BUFFER" ]] && zle up-history -w
    if [[ "$BUFFER" != "sudo "* ]]; then
        BUFFER="sudo $BUFFER"
        CURSOR=$(( CURSOR + 5 ))
    else
        BUFFER="${BUFFER#sudo }"
    fi
}
zle -N toggle-sudo

###

z4h bindkey z4h-backward-kill-word  Ctrl+Backspace
z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace
z4h bindkey z4h-kill-zword          Ctrl+Alt+Delete

z4h bindkey z4h-forward-zword       Ctrl+Alt+Right
z4h bindkey z4h-backward-zword      Ctrl+Alt+Left

z4h bindkey z4h-cd-back             Alt+Left
z4h bindkey z4h-cd-forward          Alt+Right
z4h bindkey z4h-cd-up               Alt+Up
z4h bindkey z4h-cd-down             Alt+Down

z4h bindkey toggle-sudo             Alt+S
z4h bindkey my-ctrl-z               Ctrl+Z

zle -N edit-command-line
bindkey -r '^V'
bindkey '^V^V' edit-command-line

###

setopt GLOB_DOTS

###

[ -z "$EDITOR" ] && export EDITOR='vim'
[ -z "$VISUAL" ] && export VISUAL='vim'

export DIRENV_LOG_FORMAT=
export FZF_DEFAULT_OPTS="--reverse --multi"
export SYSTEMD_LESS=FRXMK

###

command -v direnv &> /dev/null && eval "$(direnv hook zsh)"

###

z4h source -c -- /etc/bash_completion.d/azure-cli
z4h source -c -- /usr/share/LS_COLORS/dircolors.sh
z4h source -c -- /usr/share/nnn/quitcd/quitcd.bash_zsh
z4h source -c -- $ZDOTDIR/.zsh-aliases
z4h source -c -- $ZDOTDIR/.zshrc-private
z4h compile   -- $ZDOTDIR/{.zshenv,.zprofile,.zshrc,.zlogin,.zlogout}

# patch -Np1 -i ~/.dotfiles/z4h.patch -r /dev/null -d $Z4H/zsh4humans/
