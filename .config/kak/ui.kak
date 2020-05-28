colorscheme gruvbox

add-highlighter global/ number-lines -hlcursor
add-highlighter global/ show-matching
add-highlighter global/ wrap -word -indent

set-option global ui_options   ncurses_assistant=off
set-option global autoreload   yes
set-option global tabstop      4
set-option global indentwidth  4
set-option global scrolloff    2,5
set-option global idle_timeout 1000

hook global BufOpenFile .* %{ evaluate-commands -buffer %val(hook_param) %{ try %{
  execute-keys '%s^\t<ret>'
  set-option buffer indentwidth 0
}}}

hook global WinCreate .+_(LOCAL|BASE|REMOTE)_.+ %{
    set-option window autoinfo ''
}

evaluate-commands %sh{
    keyboard='{red+b}%sh{ echo "$kak_opt_langmap_current_lang " | grep -v en }{default}'
    cwd='at {cyan}%sh{ pwd | sed "s|^$HOME|~|" }{default}'
    bufname='in {green}%val{bufname}{default}'
    modified='{yellow+b}%sh{ $kak_modified && echo "[+] " }{default}'
    ft='as {magenta}%sh{ echo "${kak_opt_filetype:-noft}" }{default}'
    eol='with {yellow}%val{opt_eolformat}{default}'
    cursor='on {cyan}%val{cursor_line}{default}:{cyan}%val{cursor_char_column}{default}'
    readonly='{red+b}%sh{ [ -f "$kak_buffile" ] && [ ! -w "$kak_buffile" ] && echo "[] " }{default}'
    echo set global modelinefmt "'{{mode_info}} ${keyboard}${cwd} ${bufname} ${readonly}${modified}${ft} ${eol} ${cursor}'"
}
