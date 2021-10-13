colorscheme gruvbox

hook global WinCreate .* %{ try %{
    add-highlighter buffer/numbers  number-lines -hlcursor
    add-highlighter buffer/matching show-matching
    add-highlighter buffer/wrap     wrap -word -indent
    add-highlighter buffer/todo     regex \b(TODO|FIXME|XXX|NOTE)\b 0:default+rb
}}

set-option global ui_options   terminal_assistant=off
set-option global autoreload   yes
set-option global tabstop      4
set-option global indentwidth  4
set-option global scrolloff    2,5

hook global ModuleLoaded smarttab %{
    set-option global softtabstop 4
}

set-option global windowing_modules ''
require-module kitty
alias global popup kitty-terminal

set-option global lsp_auto_highlight_references true

hook global BufCreate '^\*scratch\*$' %{
    execute-keys -buffer *scratch* '%d'
    hook -once -always global BufCreate '^(?!\*scratch\*).*$' %{ try %{
        execute-keys -buffer *scratch* '%s\A\n\z<ret>'
        delete-buffer *scratch*
    }}
}

hook global KakBegin .* %{
    state-save-reg-load colon
    state-save-reg-load pipe
    state-save-reg-load slash
}

hook global KakEnd .* %{
    state-save-reg-save colon
    state-save-reg-save pipe
    state-save-reg-save slash
}

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
