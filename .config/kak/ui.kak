colorscheme gruvbox

face global Information rgb:ebdbb2,rgb:282828

add-highlighter global/ number-lines -hlcursor
add-highlighter global/ show-matching
add-highlighter global/ wrap -word -indent

set-option global ui_options   ncurses_assistant=off
set-option global autoreload   yes
set-option global tabstop      4
set-option global indentwidth  4
set-option global scrolloff    2,5

set-option global out_of_view_format '↑ %opt{out_of_view_selection_above_count} | ↓ %opt{out_of_view_selection_below_count}'

set-option global lsp_auto_highlight_references true

hook global BufCreate '^\*scratch\*$' %{
    execute-keys '%d'
}

evaluate-commands %sh{
    out_of_view='{yellow}%sh{ [ -n "${kak_opt_out_of_view_status_line}" ] && echo "${kak_opt_out_of_view_status_line} " }{default}'
    cwd='at {cyan}%sh{ pwd | sed "s|^$HOME|~|" }{default}'
    bufname='in {green}%val{bufname}{default}'
    modified='{yellow+b}%sh{ $kak_modified && echo "[+] " }{default}'
    ft='as {magenta}%sh{ echo "${kak_opt_filetype:-noft}" }{default}'
    eol='with {yellow}%val{opt_eolformat}{default}'
    cursor='on {cyan}%val{cursor_line}{default}:{cyan}%val{cursor_char_column}{default}'
    readonly='{red+b}%sh{ [ -f "$kak_buffile" ] && [ ! -w "$kak_buffile" ] && echo "[] " }{default}'
    echo set global modelinefmt "'{{mode_info}} ${out_of_view}${cwd} ${bufname} ${readonly}${modified}${ft} ${eol} ${cursor}'"
}
