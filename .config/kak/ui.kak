colorscheme gruvbox

set-face global LineNumbersWrapped 'rgb:3c3836'
set-face global Default 'rgb:ebdbb2,default'
set-face global BufferPadding 'rgb:504945,default'

add-highlighter global/ number_lines -hlcursor
add-highlighter global/ show_matching
add-highlighter global/ wrap -word -indent

define-command -hidden show-trailing-whitespaces %{ try %{ add-highlighter global/trailing-whitespaces regex '\h+$' 0:default,red } }
define-command -hidden hide-trailing-whitespaces %{ try %{ remove-highlighter global/trailing-whitespaces } }
hook global WinDisplay .*              show-trailing-whitespaces
hook global ModeChange 'insert:normal' show-trailing-whitespaces
hook global ModeChange 'normal:insert' hide-trailing-whitespaces

set-option global ui_options ncurses_assistant=off
set-option global autoreload yes
set-option global tabstop    4
set-option global grepcmd    'ag --column'
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
