# When a command is running, display it and when it started in the terminal title.
set-title-preexec() {
    emulate -L zsh
    print -rn -- $'\e]0;'${(%):-%*: }${(V)1}$'\a' >$TTY
}

# When no command is running, display the current directory in the terminal title.
set-title-precmd() {
    emulate -L zsh
    print -rn -- $'\e]0;'${(V%):-"%~"}$'\a' >$TTY
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd set-title-precmd
add-zsh-hook preexec set-title-preexec
set-title-precmd
