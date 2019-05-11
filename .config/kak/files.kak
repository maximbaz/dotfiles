define-command rofi-files -docstring 'Open one or many files using rg and rofi' %{ evaluate-commands %sh{
    FILES=$(rg --hidden --files | rofi -dmenu -i -multi-select)
    for file in $FILES; do
        printf 'eval -client %%{%s} edit %%{%s}\n' "$kak_client" "$file" | kak -p "$kak_session"
    done
} }

define-command rofi-buffers -docstring 'Switch to a buffer using rofi' %{ evaluate-commands %sh{
    BUFFER=$(eval set -- "$kak_buflist"; for buf in "$@"; do echo "$buf"; done | rofi -dmenu -i)
    [ -n "$BUFFER" ] && echo "eval -client '$kak_client' 'buffer $BUFFER'" | kak -p "$kak_session"
} }
