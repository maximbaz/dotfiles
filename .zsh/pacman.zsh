alias paci='pac -Sy'
alias ipaci='SNAP_PAC_SKIP=true paci'
alias pacr='pac -Rs'
alias ipacr='SNAP_PAC_SKIP=true pacr'
alias pacr!='pacr -dd'
alias ipacr!='ipacr -dd'
alias pacf='pac -U'
alias ipacf='SNAP_PAC_SKIP=true pacf'
alias pacu='pac -Syu'
alias pacq='pacman -Si'
alias pacQ='pacman -Qo'
alias pacdiff='sudo \pacdiff; py3-cmd refresh "external_script pacdiff"'

function pac() {
  sudo pacman "$@"
  py3status-refresh-pacman
}
compdef "_dispatch pacman pacman" pac

function pacs() {
  aur search -k NumVotes "$@"
  pacman -Ss "$@"
}

function aurs() {
  aur sync -sc --provides "$@"
  post_aur
}
alias aurs!='aurs --no-ver-shallow'

function aurb() {
  aur build -sc -d maximbaz-aur "$@"
  post_aur
}

function auru() {
  aur vercmp-devel "$@" | cut -d: -f1 | xargs aur sync -scu --no-ver-shallow "$@"
  post_aur
}

function post_aur() {
  sudo pacman -Sy
  py3status-refresh-pacman
  find ~/.cache/aurutils/sync -name .git -execdir git clean -fx \;
  find /var/cache/pacman/maximbaz-aur -name '*~' -delete
}

function py3status-refresh-pacman() {
  pacdiff="external_script pacdiff"
  repo="external_script updates_repo"
  aur="external_script updates_aur"
  vcs="external_script updates_vcs"

  py3-cmd refresh "$pacdiff" "$repo" "$aur" "$vcs"
}
