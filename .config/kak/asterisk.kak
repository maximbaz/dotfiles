map global normal '*' ': select-or-add-cursor<ret>'

hook global NormalKey [/?*nN]|<a-[/?*nN]> %{ try %{
    add-highlighter window/search-results-highlighter dynregex '%reg{/}' '0:black,yellow'
}}

hook global NormalKey <esc> %{ try %{
    remove-highlighter window/search-results-highlighter
}}

define-command select-or-add-cursor -docstring "search the word under cursor, auto-select if necessary" %{
    try %{
        execute-keys "<a-k>\A.\z<ret>"
        execute-keys -save-regs '' -with-hooks "_<a-i>w*"
    } catch %{
        execute-keys -save-regs '' -with-hooks "*"
    } catch nop
}
