. /usr/share/LS_COLORS/dircolors.sh

HISTFILE=~/.zhistory                        # The path to the history file.
HISTSIZE=1000000000                         # infinite command history
SAVEHIST=1000000000                         # infinite command history

PROMPT_EOL_MARK='%K{red} %k'                # mark the missing \n at the end of a comand output with a red block
ZLE_REMOVE_SUFFIX_CHARS=''                  # don't eat space when typing '|' after a tab completion
zle_highlight=('paste:none')                # disable highlighting of text pasted into the command line

ZSH_HIGHLIGHT_MAXLENGTH=1024                # don't colorize long command lines (slow)
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)  # main syntax highlighting plus matching brackets
ZSH_AUTOSUGGEST_MANUAL_REBIND=1             # disable a very slow obscure feature

fpath+=~/.zsh-plugins/archive
autoload -Uz archive lsarchive unarchive
