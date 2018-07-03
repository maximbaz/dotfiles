colorscheme gruvbox

face global LineNumbersWrapped 'rgb:3c3836'

add-highlighter global/ number_lines -hlcursor
add-highlighter global/ show_matching
add-highlighter global/ wrap -word -indent

set-option global ui_options ncurses_assistant=off
set-option global autoreload yes
set-option global tabstop    4
set-option global grepcmd    'ag --column'
