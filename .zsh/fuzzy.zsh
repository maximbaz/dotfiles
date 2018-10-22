#!/bin/zsh

bindkey '^T'  fzy-file-widget
bindkey '^R'  fzy-history-widget

zstyle :fzy:file command rg --files --hidden --smart-case 2>/dev/null
