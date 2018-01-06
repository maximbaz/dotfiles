alias ag='ag --hidden -f'
alias cp='cp -r --reflink=auto'
alias df='pydf'
alias diff='diff --color --unified'
alias dragall='dragon --and-exit --all'
alias dragon='dragon --and-exit'
alias e='nvim'
alias grep='grep --color'
alias http-serve='python3 -m http.server'
alias makepkg-compress="PKGEXT='.pkg.tar.xz' makepkg"
alias mkdir='mkdir -p'
alias o='xdg-open'
alias pacdiff='sudo \pacdiff; py3-cmd refresh "external_script pacdiff"'
alias rm='rmtrash -rf'
alias rsync='rsync --verbose --archive --info=progress2 --human-readable --compress --partial --append-verify'
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
