define-command rofi-files -docstring 'Open a file using Ag and Rofi' %{ evaluate-commands %sh{
    FILE=$(ag --hidden -f -g "" | rofi -dmenu)
    [ -n "$FILE" ] && printf 'eval -client %%{%s} edit %%{%s}\n' "${kak_client}" "${FILE}" | kak -p "${kak_session}"
} }

define-command rofi-buffers -docstring 'Switch to a buffer using Rofi' %{ evaluate-commands %sh{
    BUFFER=$(eval set -- "$kak_buflist"; for buf in "$@"; do echo "$buf"; done | rofi -dmenu)
    [ -n "$BUFFER" ] && echo "eval -client '$kak_client' 'buffer ${BUFFER}'" | kak -p ${kak_session}
} }
