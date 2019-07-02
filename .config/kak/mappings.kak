map global normal a       'li'
map global normal <space> ','
map global normal ,       '<space>'
map global normal c       '<a-c>'
map global normal <a-c>   'c'
map global normal d       '<a-d>'
map global normal <a-d>   'd'
map global normal /       '/(?i)'
map global normal <a-/>   '<a-/>(?i)'
map global normal ?       '?(?i)'
map global normal <a-?>   '<a-?>(?i)'
map global normal '#'     ': comment-line<ret>'
map global normal x       '<a-x>'
map global normal J       'J<a-x>'
map global normal K       'K<a-x>'
map global normal <left>  ': bp<ret>'
map global normal <right> ': bn<ret>'
map global normal <up>    ': lint-previous-error<ret>'
map global normal <down>  ': lint-next-error<ret>'

map global insert <c-w> '<esc>bdi'
map global insert <c-u> '<esc>xdO'

map global user -docstring 'clip-paste (before)'  p      'o<esc>!xclip -selection clipboard -o<ret>d'
map global user -docstring 'clip-paste (after)'   P      'O<esc><a-!>xclip -selection clipboard -o<ret>d'
map global user -docstring 'clip-replace'         R      '|xclip -selection clipboard -o<ret>'
map global user -docstring 'clip-yank'            y      '<a-|>xclip -selection clipboard -i<ret>'
map global user -docstring 'save buffer'          w      ': w<ret>'
map global user -docstring 'close buffer'         c      ': db<ret>'
map global user -docstring 'kill buffer'          C      ': db!<ret>'
map global user -docstring 'save all and exit'    q      ': waq<ret>'
map global user -docstring 'exit without save'    Q      ': q!<ret>'
map global user -docstring 'rofi-buffers'         b      ': rofi-buffers<ret>'
map global user -docstring 'rofi-files'           f      ': rofi-files<ret>'
map global user -docstring 'rofi-files-in-folder' F      ': rofi-files-in-folder<ret>'
map global user -docstring 'edit kakrc'           e      ': e ~/.config/kak/kakrc<ret>'
map global user -docstring 'codepoint'            i      ': echo %sh{ printf "codepoint: U+%04x" "$kak_cursor_char_value" }<ret>'
map global user -docstring 'surround'             s      ': auto-pairs-surround<ret>'
map global user -docstring 'select down'          V      ': vertical-selection-down<ret>'
map global user -docstring 'select up'            <a-v>  ': vertical-selection-up<ret>'
map global user -docstring 'select up and down'   v      ': vertical-selection-up-and-down<ret>'
map global user -docstring 'new terminal in cwd'  n      ' :kitty-terminal zsh<ret>'

define-command -hidden -params 1 extend-line-down %{ execute-keys "<a-:>%arg{1}X" }
define-command -hidden -params 1 extend-line-up   %{
    try %{
        execute-keys "<a-K>\n<ret>"
        execute-keys "<a-:><a-;>%arg{1}KJ<a-x>"
    } catch %{
        execute-keys "<a-:><a-;>%arg{1}K<a-x>"
    }
}

hook global InsertChar \t %{ try %{
  execute-keys -draft "h<a-h><a-k>\A\h+\z<ret><a-;>;%opt{indentwidth}@"
}}
hook global InsertDelete ' ' %{ try %{
  execute-keys -draft 'h<a-h><a-k>\A\h+\z<ret>i<space><esc><lt>'
}}
