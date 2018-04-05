alias ipaci='SNAP_PAC_SKIP=true paci'
alias ipacr='SNAP_PAC_SKIP=true pacr'
alias ipacf='SNAP_PAC_SKIP=true pacf'
alias pacu='sudo pacman -Syu; py3status-refresh-pacman'
alias pacq='pacman -Si'
alias pacQ='pacman -Qo'
alias pacdiff='sudo \pacdiff; py3-cmd refresh "external_script pacdiff"'

function paci {
  sudo pacman -Sy "$@"
  py3status-refresh-pacman
}

function pacr {
  sudo pacman -Rs "$@"
  py3status-refresh-pacman
}

function pacf {
  sudo pacman -U "$@"
  py3status-refresh-pacman
}

function pacs {
  aur search -k NumVotes "$@"
  pacman -Ss "$@"
}

function aur {
  /usr/bin/aur "$@"
  notify-send "aur" "$*"
  py3status-refresh-pacman
}

function py3status-refresh-pacman {
  pacdiff="external_script pacdiff"
  repo="external_script updates_repo"
  aur="external_script updates_aur"
  vcs="external_script updates_vcs"

  py3-cmd refresh "$pacdiff" "$repo" "$aur" "$vcs"
}
