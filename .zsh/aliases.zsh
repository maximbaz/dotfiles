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

alias ls="exa --git --group-directories-first"
alias ll="ls -l"
alias la="ll -a"
alias lk="ll -s=size"                # Sorted by size
alias lm="ll -s=modified"            # Sorted by modified date
alias lc="ll --created -s=created"   # Sorted by created date

alias pac='sudo pacman -Sy; yay'
alias paci='sudo pacman -Sy'
alias pacf='sudo pacman -U'
alias pacu='sudo pacman -Syu; py3-cmd refresh arch_updates "external_script pacdiff"'
alias pacr='sudo pacman -Rs'
alias pacq='pacman -Si'
alias pacQ='pacman -Qo'

function mkdcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}
