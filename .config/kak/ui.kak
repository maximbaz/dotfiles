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

set-option global lsp_auto_highlight_references true

hook global BufOpenFile .* %{ evaluate-commands -buffer %val(hook_param) %{ try %{
  execute-keys '%s^\t<ret>'
  set-option buffer indentwidth 0
}}}

evaluate-commands %sh{
    cwd='at {cyan}%sh{ pwd | sed "s|^$HOME|~|" }{default}'
    bufname='in {green}%val{bufname}{default}'
    modified='{yellow+b}%sh{ $kak_modified && echo "[+] " }{default}'
    ft='as {magenta}%sh{ echo "${kak_opt_filetype:-noft}" }{default}'
    eol='with {yellow}%val{opt_eolformat}{default}'
    cursor='on {cyan}%val{cursor_line}{default}:{cyan}%val{cursor_char_column}{default}'
    readonly='{red+b}%sh{ [ -f "$kak_buffile" ] && [ ! -w "$kak_buffile" ] && echo "[] " }{default}'
    echo set global modelinefmt "'{{mode_info}} ${cwd} ${bufname} ${readonly}${modified}${ft} ${eol} ${cursor}'"
}
