# history widget with preview and syntax highlighting
my-fuzzy-history-widget() {
    emulate -L zsh -o pipefail
    local preview='zsh -dfc "setopt extended_glob; echo - \${\${1#*[0-9] }## #}" -- {}'
    (( $+commands[bat] )) && preview+=' | bat -l bash --color always -pp'
    local selected
    selected="$(
        fc -rl 1 |
        fzf +m -n2..,.. --tiebreak=index --cycle --height=80% --preview-window=down:30%:wrap --query=$LBUFFER --preview=$preview)"
    local -i ret=$?
    [[ -n "$selected" ]] && zle vi-fetch-history -n $selected
    zle .reset-prompt
    return ret
}
zle -N my-fuzzy-history-widget

# Widgets for changing current working directory.
my-redraw-prompt() {
    emulate -L zsh
    local f
    for f in chpwd $chpwd_functions precmd $precmd_functions; do
        (( $+functions[$f] )) && $f &>/dev/null
    done
    zle .reset-prompt
    zle -R
}

my-cd-rotate() {
    emulate -L zsh
    while (( $#dirstack )) && ! pushd -q $1 &>/dev/null; do
        popd -q $1
    done
    if (( $#dirstack )); then
        my-redraw-prompt
    fi
}

my-cd-back() { my-cd-rotate +1 }
zle -N my-cd-back

my-cd-forward() { my-cd-rotate -0 }
zle -N my-cd-forward

my-cd-up() { cd .. && my-redraw-prompt }
zle -N my-cd-up

# Toggle comment
my-pound-toggle() {
    if [[ "$BUFFER" = '#'* ]]; then
        if [[ $CURSOR != $#BUFFER ]]; then
            (( CURSOR -= 1 ))
        fi
        BUFFER="${BUFFER:1}"
    else
        BUFFER="#$BUFFER"
        (( CURSOR += 1 ))
    fi
}
zle -N my-pound-toggle

# Allow command line editing in an external editor.
autoload -Uz edit-command-line
zle -N edit-command-line

# Expands ... to ../..
my-expand-dot-to-parent-directory-path() {
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+='/..'
    else
        LBUFFER+='.'
    fi
}
zle -N my-expand-dot-to-parent-directory-path

# Make Ctrl-D work with p10k instant prompt
my-ctrl-d() {
    zle || exit 0
    [[ -n $BUFFER ]] && return
    typeset -g precmd_functions=(my-ctrl-d)
    zle accept-line
}
zle -N my-ctrl-d

# Make Ctrl+Z toggle Ctrl+Z and fg
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

# First tab partially completes, second Tab shows fzf-tab
fzf-tab-partial-and-complete() {
    if [[ $LASTWIDGET = 'fzf-tab-partial-and-complete' ]]; then
        fzf-tab-complete
    else
        zle complete-word
    fi
}
zle -N fzf-tab-partial-and-complete
