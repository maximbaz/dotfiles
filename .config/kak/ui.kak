colorscheme gruvbox

set-face global Default 'rgb:ebdbb2,default'
set-face global BufferPadding 'rgb:504945,default'

add-highlighter global/ number-lines -hlcursor
add-highlighter global/ show-matching
add-highlighter global/ wrap -word -indent

set-option global ui_options ncurses_assistant=off
set-option global autoreload yes
set-option global tabstop    4
set-option global scrolloff  2,5

evaluate-commands %sh{
    cwd='at {cyan}%sh{dirs +0}{default}'
    bufname='in {green}%val{bufname}{default}'
    modified='{yellow+b}%sh{$kak_modified && echo "[+] "}{default}'
    ft='as {magenta}%sh{echo "${kak_opt_filetype:-noft}"}{default}'
    eol='with {yellow}%val{opt_eolformat}{default}'
    cursor='on {cyan}%val{cursor_line}{default}:{cyan}%val{cursor_char_column}{default}'
    echo set global modelinefmt "'{{mode_info}} ${cwd} ${bufname} ${modified}${ft} ${eol} ${cursor}'"
}
