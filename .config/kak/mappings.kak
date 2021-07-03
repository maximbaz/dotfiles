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
map global normal <up>    ': git prev-hunk<ret>'
map global normal <down>  ': git next-hunk<ret>'
map global normal <c-n>   ': connect-terminal<ret>'

map global insert <c-w>   '<esc>bdi'
map global insert <c-u>   '<esc>xdO'

map global user -docstring 'clip-paste (before)'      p      '<a-!>wl-paste --no-newline | dos2unix<ret>'
map global user -docstring 'clip-paste (after)'       P      '!wl-paste --no-newline | dos2unix<ret>'
map global user -docstring 'clip-replace'             R      '|wl-paste --no-newline | dos2unix<ret>'
map global user -docstring 'clip-yank'                y      '<a-|>wl-copy<ret>'
map global user -docstring 'save buffer'              w      ': w<ret>'
map global user -docstring 'close buffer'             c      ': db<ret>'
map global user -docstring 'kill buffer'              C      ': db!<ret>'
map global user -docstring 'save all and exit'        q      ': waq<ret>'
map global user -docstring 'exit without save'        Q      ': q!<ret>'
map global user -docstring 'buffers'                  b      ': buffers<ret>'
map global user -docstring 'files'                    f      ': files<ret>'
map global user -docstring 'edit kakrc'               e      ': e ~/.config/kak/kakrc<ret>'
map global user -docstring 'lsp hover'                h      ': lsp-hover<ret>'
map global user -docstring 'codepoint'                i      ': echo %sh{ printf "codepoint: U+%04x" "$kak_cursor_char_value" }<ret>'
map global user -docstring 'surround'                 s      ': enter-user-mode surround<ret>'
map global user -docstring 'select down'              V      ': vertical-selection-down<ret>'
map global user -docstring 'select up'                <a-v>  ': vertical-selection-up<ret>'
map global user -docstring 'select up and down'       v      ': vertical-selection-up-and-down<ret>'
map global user -docstring 'disable autoformat'       d      ': disable-autoformat<ret>'
map global user -docstring 'LSP mode'                 l      ': enter-user-mode lsp<ret>'
map global user -docstring 'toggle line numbers'      L      ': toggle-highlighter buffer/numbers number-lines -hlcursor<ret>'
map global user -docstring 'toggle line wrap'         W      ': toggle-highlighter buffer/wrap wrap -word -indent<ret>'

define-command cd-buffer -docstring 'Change the working directory to the current buffer directory' %{
    evaluate-commands -buffer %val{buffile}%{
        change-directory %sh(dirname "$kak_buffile")
    }
}

hook global InsertChar \t %{ try %{
    execute-keys -draft "h<a-h><a-k>\A\h+\z<ret><a-;>;%opt{indentwidth}@"
}}

hook global InsertDelete ' ' %{ try %{
    execute-keys -draft 'h<a-h><a-k>\A\h+\z<ret>i<space><esc><lt>'
}}
