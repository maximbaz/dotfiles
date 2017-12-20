alias ag='ag --hidden -f'
alias cp='cp -r'
alias df='pydf'
alias diff='diff --color --unified'
alias dragall='dragon --and-exit --all'
alias dragon='dragon --and-exit'
alias e='nvim'
alias etcchanges="sudo DIFFPROG='nvim -d' pacdiff"
alias http-serve='python3 -m http.server'
alias mkdir='mkdir -p'
alias o='xdg-open'
alias rm='rmtrash -rf'
alias rsync='rsync --verbose --archive --info=progress2 --human-readable --compress'
alias sudo='sudo -E '
alias vi='nvim'
alias vim='nvim'

alias ls="ls --color=auto --group-directories-first"
alias ll="ls -lh"
alias la="ll -A"
alias lk="ll -Sr"   # Sorted by size
alias lt="ll -tr"   # Sorted by date

function mkdcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}
