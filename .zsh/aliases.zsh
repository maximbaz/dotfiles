alias ag='ag --hidden -f'
alias cp='cp -r --reflink=auto'
alias df='pydf'
alias diff='diff --color --unified'
alias dragall='dragon-drag-and-drop --and-exit --all'
alias dragon='dragon-drag-and-drop --and-exit'
alias e='kak'
alias grep='grep --color'
alias http-serve='python3 -m http.server'
alias locate='locate -i'
alias makepkg-compress="PKGEXT='.pkg.tar.xz' makepkg"
alias mkdir='mkdir -p'
alias o='xdg-open'
alias rm='rmtrash -rf'
alias rm!='\rm -rf'
alias rsync='rsync --verbose --archive --info=progress2 --human-readable --compress --partial'
alias sudo='sudo -E '
alias vi='nvim'
alias vim='nvim'

alias ls="exa --git --group-directories-first"
alias ll="ls -l"
alias la="ll -a"
alias lk="ll -s=size"                # Sorted by size
alias lm="ll -s=modified"            # Sorted by modified date
alias lc="ll --created -s=created"   # Sorted by created date

function mkdcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}
