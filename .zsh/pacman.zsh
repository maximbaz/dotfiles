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
alias pacQ='pacman -Qo'
alias pacdiff='sudo \pacdiff; py3-cmd refresh "external_script pacdiff"'

pac() {
  sudo pacman "$@"
  py3status-refresh-pacman
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

aurs() {
  aur sync -scP "$@"
  post_aur
}
alias aurs!='aurs --no-ver-shallow'

aurb() {
  aur build -sc "$@"
  post_aur
}

auru() {
  xargs -a <(aur vercmp-devel | cut -d: -f1) aur sync -scuP --rebuild "$@"
  post_aur
}

post_aur() {
  sudo pacman -Sy
  py3status-refresh-pacman
  find ~/.cache/aurutils/sync -name .git -execdir git clean -fx \;
  find /var/cache/pacman/maximbaz -name '*~' -delete
}

py3status-refresh-pacman() {
  pacdiff="external_script pacdiff"
  official="external_script checkofficial"
  repo="external_script checkupdates"
  aur="external_script checkupdates_aur"
  vcs="external_script checkupdates_vcs"
  rebuild="external_script checkrebuild"

  py3-cmd refresh "$pacdiff" "$official" "$repo" "$aur" "$vcs" "$rebuild"
}
