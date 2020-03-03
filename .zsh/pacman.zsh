#!/bin/zsh

alias aurc='aur talk -bin 5'
alias paci='pac -Sy'
alias ipaci='SNAP_PAC_SKIP=true paci'
alias ipaci!='ipaci -dd'
alias pacr='pac -Rs'
alias ipacr='SNAP_PAC_SKIP=true pacr'
alias pacr!='pacr -dd'
alias ipacr!='ipacr -dd'
alias pacf='pac -U'
alias ipacf='SNAP_PAC_SKIP=true pacf'
alias pacu='pac -Syu'
alias ipacu='SNAP_PAC_SKIP=true pacu'
alias pacq='pacman -Si'
alias pacl='pacman -Ql'
alias pacdiff='sudo \pacdiff; pkill -RTMIN+1 -x waybar'

pac() {
    sudo -E pacman "$@"
    pkill -RTMIN+1 -x waybar
    rehash
}
compdef pac=pacman

pacs() {
    aur search -n -k NumVotes "$@"
    pacman -Ss "$@"
}

pacs!() {
    aur search -k NumVotes "$@"
    pacman -Ss "$@"
}

pacQ() {
    pacman -Qo `which "$1"`
}

aurs() {
    aur sync -ScP "$@"
    post_aur
}
alias aurs!='aurs --no-ver-shallow -f'

aurb() {
    aur build -Scf --pkgver "$@"
    post_aur
}

auru() {
    xargs -a <(aur vercmp-devel | cut -d: -f1) aur sync -ScPu --rebuild "$@"
    post_aur
}

post_aur() {
    sudo -E pacman -Sy
    pkill -RTMIN+1 -x waybar
    find ~/.cache/aurutils/sync -name .git -execdir git clean -fx \; >/dev/null
    find /var/cache/pacman/maximbaz -name '*~' -delete >/dev/null
    find /var/cache/pacman/maximbaz -group root -delete >/dev/null
}
