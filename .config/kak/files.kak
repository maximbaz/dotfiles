define-command rofi-files -docstring 'Open one or many files' %{ evaluate-commands %sh{
    FILES=$(rg --hidden --files | rofi -dmenu -i -multi-select -sort)
    for file in $FILES; do
        printf 'eval -client %%{%s} edit %%{%s}\n' "$kak_client" "$file" | kak -p "$kak_session"
    done
} }

define-command rofi-files-in-folder -docstring 'Open one or many files in a recent folder' %{ evaluate-commands %sh{
    FOLDER=$(cat "$HOME/.z" | sed 's/|/\t/g' | sort -rnk2 | awk '{print $1}' | sed "s|$HOME|~|g" | rofi -dmenu -i | sed "s|~|$HOME|g")
    if [ -n "$FOLDER" ]; then
        FILES=$(rg --hidden --files "$FOLDER" | sed "s|$FOLDER/||g" | rofi -dmenu -i -multi-select -sort)
        for file in $FILES; do
            printf 'eval -client %%{%s} edit %%{%s}\n' "$kak_client" "$FOLDER/$file" | kak -p "$kak_session"
        done
    fi
} }

define-command rofi-buffers -docstring 'Switch to a buffer' %{ evaluate-commands %sh{
    BUFFER=$(eval set -- "$kak_buflist"; for buf in "$@"; do echo "$buf"; done | rofi -dmenu -i -sort)
    [ -n "$BUFFER" ] && echo "eval -client '$kak_client' 'buffer $BUFFER'" | kak -p "$kak_session"
} }
