alias paci='pac -Sy'
alias ipaci='SNAP_PAC_SKIP=true paci'
alias pacr='pac -Rs'
alias ipacr='SNAP_PAC_SKIP=true pacr'
alias pacf='pac -U'
alias ipacf='SNAP_PAC_SKIP=true pacf'
alias pacu='sudo pacman -Syu; py3status-refresh-pacman'
alias pacq='pacman -Si'
alias pacQ='pacman -Qo'
alias pacdiff='sudo \pacdiff; py3-cmd refresh "external_script pacdiff"'

alias aurs='aur sync -sc --provides'
alias auru='aur sync -scu --devel --provides --noreset'
alias aurb='aur build -sc -d maximbaz-aur'

function pac {
  sudo pacman "$@"
  py3status-refresh-pacman
}
compdef "_dispatch pacman pacman" pac

function pacs {
  /usr/bin/aur search -k NumVotes "$@"
  pacman -Ss "$@"
}

function aur {
  /usr/bin/aur "$@"
  sudo pacman -Sy
  py3status-refresh-pacman
  find ~/.cache/aurutils/sync \( -name '*.tar' -o -name '*.tar.gz' -o -name '*.zip' -o -name '*.deb' -o -name '*.log' \) -delete
  find /var/cache/pacman/maximbaz-aur -name '*~' -delete
}

function py3status-refresh-pacman {
  pacdiff="external_script pacdiff"
  repo="external_script updates_repo"
  aur="external_script updates_aur"
  vcs="external_script updates_vcs"

  py3-cmd refresh "$pacdiff" "$repo" "$aur" "$vcs"
}
