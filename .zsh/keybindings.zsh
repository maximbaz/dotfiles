bindkey -e  # enable emacs keymap

# If NumLock is off, translate keys to make them appear the same as with NumLock on.
bindkey -s '^[OM' '^M'  # enter
bindkey -s '^[Ok' '+'
bindkey -s '^[Om' '-'
bindkey -s '^[Oj' '*'
bindkey -s '^[Oo' '/'
bindkey -s '^[OX' '='

# If someone switches our terminal to application mode (smkx), translate keys to make
# them appear the same as in raw mode (rmkx).
bindkey -s '^[OH' '^[[H'  # home
bindkey -s '^[OF' '^[[F'  # end
bindkey -s '^[OA' '^[[A'  # up
bindkey -s '^[OB' '^[[B'  # down
bindkey -s '^[OD' '^[[D'  # left
bindkey -s '^[OC' '^[[C'  # right

# TTY sends different key codes. Translate them to regular.
bindkey -s '^[[1~' '^[[H'  # home
bindkey -s '^[[4~' '^[[F'  # end

# Do nothing on pageup and pagedown. Better than printing '~'.
bindkey -s '^[[5~' ''
bindkey -s '^[[6~' ''

bindkey '^[[D'    backward-char                           # left       move cursor one char backward
bindkey '^[[C'    forward-char                            # right      move cursor one char forward
bindkey '^[[A'    history-substring-search-up             # up         prev command in history
bindkey '^[[B'    history-substring-search-down           # down       next command in local history
bindkey '^[[H'    beginning-of-line                       # home       go to the beginning of line
bindkey '^[[F'    end-of-line                             # end        go to the end of line
bindkey '^?'      backward-delete-char                    # bs         delete one char backward
bindkey '^[[3~'   delete-char                             # delete     delete one char forward
bindkey '^[[1;5C' forward-word                            # ctrl+right go forward one word
bindkey '^[[1;5D' backward-word                           # ctrl+left  go backward one word
bindkey '^H'      backward-kill-word                      # ctrl+bs    delete previous word
bindkey '^[[3;5~' kill-word                               # ctrl+del   delete next word
bindkey '^K'      kill-line                               # ctrl+k     delete line after cursor
bindkey '^J'      backward-kill-line                      # ctrl+j     delete line before cursor
bindkey '^N'      kill-buffer                             # ctrl+n     delete all lines
bindkey '^[/'     undo                                    # alt+/      undo
bindkey '^[\'     redo                                    # alt+\      redo
bindkey '^[[1;3D' my-cd-back                              # alt+left   cd into the prev directory
bindkey '^[[1;3C' my-cd-forward                           # alt+right  cd into the next directory
bindkey '^[[1;3A' my-cd-up                                # alt+up     cd ..
bindkey '^[[1;3B' fzf-cd-widget                           # alt+down   fuzzy cd
bindkey '^T'      fzf-completion                          # ctrl+t     fuzzy file completion
bindkey '^R'      my-fuzzy-history-widget                 # ctrl+r     fuzzy history
bindkey '^_'      my-pound-toggle                         # ctrl+/     toggle comment
bindkey '^V^V'    edit-command-line                       # ctrl+vv    edit command in EDITOR
bindkey '.'       my-expand-dot-to-parent-directory-path  # .          expand ... to ../..
bindkey '^D'      my-ctrl-d                               # ctrl+d     better ctrl+d
bindkey '^Z'      my-ctrl-z                               # ctrl+z     better ctrl+z
bindkey '^I'      fzf-tab-partial-and-complete            # tab        partial complete and then fuzzy complete
