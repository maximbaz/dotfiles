# %sh{kak-lsp --kakoune -s $kak_session}
# lsp-auto-hover-insert-mode-enable


# Commands

define-command disable-autolint -docstring 'disable auto-lint' %{
    lint-disable
    unset-option window lintcmd
    remove-hooks window lint
}

define-command disable-autoformat -docstring 'disable auto-format' %{
    unset-option window formatcmd
    remove-hooks window format
}


# Hooks

hook global BufOpenFile  .* modeline-parse
hook global BufCreate    .* editorconfig-load
hook global BufWritePre  .* %{ nop %sh{ mkdir -p $(dirname "$kak_hook_param") }}
hook global BufWritePost .* %{ git show-diff }
# hook global WinCreate    .* auto-pairs-enable
hook global WinDisplay   .* %{ evaluate-commands %sh{
    cd "$(dirname "$kak_buffile")"
    project_dir="$(git rev-parse --show-toplevel 2>/dev/null)"
    [[ -n "$project_dir" ]] && dir="$project_dir" || dir="${PWD%/.git}"
    printf "cd %%{%s}\n" "$dir"
    [[ -n "$project_dir" ]] && printf "git show-diff"
} }


hook global WinSetOption filetype=.* %{
    disable-autolint
    disable-autoformat
    # go-disable-autocomplete

    hook window -group format BufWritePre .* %{ try %{ execute-keys -draft \%s\h+$<ret>d } }
}

hook global WinSetOption filetype=python %{
    set-option window lintcmd 'pylint --msg-template="{path}:{line}:{column}: {category}: {msg}" -rn -sn'
    lint-enable
    lint
    hook window -group lint BufWritePost .* lint

    set-option window formatcmd 'yapf'
    hook window -group format BufWritePre .* format
}

hook global WinSetOption filetype=go %{
    set-option window lintcmd "run() { sync; cp $1 $1.go; golint $1.go; go vet $1.go 2>&1 | sed -E 's/: /: error: /'; } && run"
    lint-enable
    lint
    hook window -group lint BufWritePost .* lint

    hook window -group format BufWritePre .* %{ go-format -use-goimports }

    go-enable-autocomplete
}

hook global WinSetOption filetype=(javascript|typescript|css|scss|json|markdown|yaml) %{
    set-option window formatcmd "prettier --stdin-filepath=${kak_buffile}"
    hook window -group format BufWritePre .* format
}

hook global WinSetOption filetype=sh %{
    set-option window lintcmd 'shellcheck -x -fgcc'
    lint-enable
    lint
}
