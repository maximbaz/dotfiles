define-command files -docstring 'Open one or many files' %{ evaluate-commands %sh{
    FILES=$(rg --hidden --files | dmenu -k -p files)
    for file in $FILES; do
        printf 'eval -client %%{%s} edit %%{%s}\n' "$kak_client" "$file" | kak -p "$kak_session"
    done
} }

define-command buffers -docstring 'Switch to a buffer' %{ evaluate-commands %sh{
    BUFFER=$(eval set -- "$kak_buflist"; for buf in "$@"; do echo "$buf"; done | dmenu -k -p buffer)
    [ -n "$BUFFER" ] && echo "eval -client '$kak_client' 'buffer $BUFFER'" | kak -p "$kak_session"
} }
