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
map global normal x       ': extend-line-down %val{count}<ret>'
map global normal X       ': extend-line-up %val{count}<ret>'

map global user -docstring 'clip-paste (before)' p 'o<esc>!xclip -selection clipboard -o<ret>d'
map global user -docstring 'clip-paste (after)'  P 'O<esc><a-!>xclip -selection clipboard -o<ret>d'
map global user -docstring 'clip-replace'        R '|xclip -selection clipboard -o<ret>'
map global user -docstring 'clip-yank'           y '<a-|>xclip -selection clipboard -i<ret>'
map global user -docstring 'save buffer'         w ': w<ret>'
map global user -docstring 'close buffer'        c ': db<ret>'
map global user -docstring 'save all and exit'   q ': waq<ret>'
map global user -docstring 'exit without save'   Q ': q!<ret>'
map global user -docstring 'rofi-buffers'        b ': rofi-buffers<ret>'
map global user -docstring 'rofi-files'          f ': rofi-files<ret>'
map global user -docstring 'edit kakrc'          e ': e ~/.config/kak/kakrc<ret>'
map global user -docstring 'codepoint'           i ': echo %sh{ printf "codepoint: U+%04x" "$kak_cursor_char_value" }<ret>'

define-command -hidden -params 1 extend-line-down %{ execute-keys "<a-:>%arg{1}X" }
define-command -hidden -params 1 extend-line-up   %{
    try %{
        execute-keys "<a-K>\n<ret>"
        execute-keys "<a-:><a-;>%arg{1}KJ<a-x>"
    } catch %{
        execute-keys "<a-:><a-;>%arg{1}K<a-x>"
    }
}

# lsp
# map global user -docstring 'lsp-info'            i ':lsp-hover<ret>'

# lint
# map global user -docstring 'next lint error'               ] ':lint-next-error<ret>'
# map global user -docstring 'previous lint error'           [ ':lint-previous-error<ret>'

# declare-user-mode surround
# map global surround s ':surround<ret>' -docstring 'surround'
# map global surround c ':change-surround<ret>' -docstring 'change'
# map global surround d ':delete-surround<ret>' -docstring 'delete'
# map global surruond t ':select-surrounding-tag<ret>' -docstring 'select tag'
# map global normal 'some key' ':enter-user-mode surround<ret>'


# map global user v :select-down<ret>
# map global user <a-v> :select-up<ret>
# map global user V :select-vertically<ret>

# map global normal <a-,> :bp<ret>
# map global normal <a-.> :bn<ret>
# map global normal <a-r> :e!<ret>
# map global normal <a-d> :db<ret>
# map global normal <a-q> :db!<ret>
