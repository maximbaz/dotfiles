source /usr/share/kak-lsp/rc/lsp.kak
lsp-enable
lsp-auto-hover-insert-mode-enable
lsp-auto-hover-enable
set-option global lsp_auto_highlight_references true
set-option global lsp_hover_anchor true

set-option global grepcmd 'ag --column --hidden -f'

set-option global langmap %opt{langmap_ru_jcuken}

hook global ModuleLoaded kitty %{
   set-option global kitty_window_type 'os'
}

# Commands

define-command disable-autolint -docstring 'disable auto-lint' %{
    lint-disable
    unset-option buffer lintcmd
    remove-hooks buffer lint
}

define-command disable-autoformat -docstring 'disable auto-format' %{
    unset-option buffer formatcmd
    remove-hooks buffer format
}


# Hooks

hook global BufOpenFile  .* modeline-parse
hook global BufCreate    .* %{ editorconfig-load; set buffer eolformat lf }
hook global BufWritePre  .* %{ nop %sh{ mkdir -p $(dirname "$kak_hook_param") }}
hook global BufWritePost .* %{ git show-diff }
hook global BufReload    .* %{ git show-diff }
hook global WinCreate    .* auto-pairs-enable
hook global WinDisplay   .* %{ evaluate-commands %sh{
    cd "$(dirname "$kak_buffile")"
    project_dir="$(git rev-parse --show-toplevel 2>/dev/null)"
    [ -n "$project_dir" ] && dir="$project_dir" || dir="${PWD%/.git}"
    printf "cd %%{%s}\n" "$dir"
    [ -n "$project_dir" ] && [ "$kak_buffile" = "${kak_buffile#\*}" ] && printf "git show-diff"
} }


hook global WinSetOption filetype=.* %{
    disable-autoformat
    disable-autolint

    hook buffer -group format BufWritePre .* %{
        try %{ execute-keys -draft '%s\h+$<ret>d' }
        try %{ execute-keys -draft '%s\u000d<ret>d' }
    }
}

hook global WinSetOption filetype=python %{
    set-option buffer formatcmd 'black -q -'
    hook buffer -group format BufWritePre .* format

    set-option buffer lintcmd 'pylint --msg-template="{path}:{line}:{column}: {category}: {msg}" -rn -sn'
    lint-enable
    lint
    hook buffer -group lint BufWritePost .* lint
}

hook global WinSetOption filetype=go %{
    hook buffer -group format BufWritePost .* %{ evaluate-commands %sh{ goimports -e -w "$kak_buffile" }; edit! }

    set-option buffer lintcmd "run() { golint $1; go vet $1 2>&1 | sed -E 's/: /: error: /'; } && run"
    lint-enable
    lint
    hook buffer -group lint BufWritePost .* lint
}

hook global WinSetOption filetype=rust %{
    hook buffer -group format BufWritePre .* lsp-formatting-sync
}

hook global WinSetOption filetype=(javascript|typescript|css|scss|json|markdown|yaml|html) %{
    set-option buffer formatcmd "prettier --stdin-filepath=${kak_buffile}"
    hook buffer -group format BufWritePre .* format
}

hook global WinSetOption filetype=markdown %{
    set-option -add buffer auto_pairs_surround _ _ * *
}

hook global WinSetOption filetype=sh %{
    set-option buffer lintcmd 'shellcheck -x -fgcc'
    lint-enable
    lint
}
