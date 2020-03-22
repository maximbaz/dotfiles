. /usr/share/LS_COLORS/dircolors.sh

HISTFILE=~/.zhistory                         # The path to the history file.
HISTSIZE=1000000000                          # infinite command history
SAVEHIST=1000000000                          # infinite command history

TIMEFMT='user=%U system=%S cpu=%P total=%*E' # more concize `time` output
PROMPT_EOL_MARK='%K{red} %k'                 # mark the missing \n at the end of a comand output with a red block
ZLE_REMOVE_SUFFIX_CHARS=''                   # don't eat space when typing '|' after a tab completion
zle_highlight=('paste:none')                 # disable highlighting of text pasted into the command line

ZSH_HIGHLIGHT_MAXLENGTH=1024                 # don't colorize long command lines (slow)
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)   # main syntax highlighting plus matching brackets
ZSH_AUTOSUGGEST_MANUAL_REBIND=1              # disable a very slow obscure feature

export EDITOR='kak'
export VISUAL='kak'
export DIFFPROG='meld'
export MANPAGER='kak-man-pager'
export AUR_PAGER='nnn -Aer'
export WORDCHARS='*?_.[]~&!#$%^(){}<>'

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"

export PASSWORD_STORE_CHARACTER_SET='a-zA-Z0-9~!@#$%^&*()-_=+[]{};:,.<>?'
export PASSWORD_STORE_GENERATED_LENGTH=40

export GOPATH="$HOME/.go"
export GOPRIVATE="bitbucket.org/maersk-analytics"

export NNN_TRASH=1
export NNN_COLORS='4235'
export NNN_PLUG='j:jump;r:remove;c:croc;d:dragdrop;'
export NNN_BMS='d:~/Downloads;n:/home/nzbget/dst;N:/home/nzbget/nzb;r:/run/media/maximbaz;'

fpath+=~/.zsh-plugins/archive
autoload -Uz archive lsarchive unarchive
