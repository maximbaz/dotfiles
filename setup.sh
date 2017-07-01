#!/bin/bash

set -e

dotfiles_dir="$(cd "$(dirname "$0")"; pwd)"
cd "$dotfiles_dir"

link() {
  create_link "$dotfiles_dir/$1" "$HOME/$1"
}

systemd_service_link() {
  link ".config/systemd/user/$1.service"
  systemctl --user enable "$1.service"
  systemctl --user start "$1.service"
}

systemd_timer_link() {
  link ".config/systemd/user/$1.service"
  link ".config/systemd/user/$1.timer"
  systemctl --user enable "$1.timer"
  systemctl --user start "$1.timer"
}

create_link() {
  orig_file="$1"
  dest_file="$2"

  mkdir -p "$(dirname "$orig_file")"
  mkdir -p "$(dirname "$dest_file")"

  rm -rf $dest_file
  ln -s $orig_file $dest_file

  echo "$dest_file -> $orig_file"
}

root_copy() {
  orig_file="$dotfiles_dir/$1"
  dest_file="/$1"

  sudo mkdir -p "$(dirname "$orig_file")"
  sudo mkdir -p "$(dirname "$dest_file")"

  sudo rm -rf $dest_file
  sudo cp -R "$orig_file" "$dest_file"

  echo "$dest_file <= $orig_file"
}

sudo_systemd_enable_start() {
  echo "systemctl enable & start: $1"
  sudo systemctl enable "$1"
  sudo systemctl start "$1"
}

if [ "$(whoami)" != "root"  ]; then
  link "bin"
  link "lib"

  link ".i3/config"
  link ".i3status.conf"

  link ".ghc/ghci.conf"
  link ".gnupg/gpg-agent.conf"

  link ".config/alacritty/alacritty.yml"
  link ".config/Cerebro/config.json"
  link ".config/chromium-flags.conf"
  link ".config/copyq/copyq.conf"
  link ".config/dunst"
  link ".config/fontconfig/conf.d/30-infinality-custom.conf"
  link ".config/fontconfig/conf.d/70-emojione-color.conf"
  link ".config/fontconfig/conf.d/70-monospace.conf"
  link ".config/gsimplecal"
  link ".config/gtk-3.0"
  link ".config/htop"
  link ".config/mpv/mpv.conf"
  link ".config/nvim/init.vim"
  link ".config/ranger/rc.conf"
  link ".config/redshift.conf"
  link ".config/TheHive"
  link ".config/transmission/settings.json"

  link ".local/share/fonts"

  link ".agignore"
  link ".compton.conf"
  link ".gitconfig"
  link ".gtkrc-2.0"
  link ".npmrc"
  link ".pylintrc"
  link ".tigrc"
  link ".tmux.conf"
  link ".xinitrc"
  link ".Xresources"
  link ".zpreztorc"
  link ".zprofile"
  link ".zsh"
  link ".zsh.prompts"
  link ".zshrc"

  systemd_service_link "tmux"
  systemd_timer_link "pacman-backup"
  systemd_timer_link "wallpaper"

  # Disable dropbox autoupdate
  rm -rf ~/.dropbox-dist
  install -dm0 ~/.dropbox-dist

  # Do not get bugged by position changes stored in this config
  git update-index --assume-unchanged ".config/TheHive/HotShots.conf"

  root_copy "etc/NetworkManager/dispatcher.d/pia-vpn"
  root_copy "etc/private-internet-access/pia.conf"
  root_copy "etc/sysctl.d/10-swappiness.conf"
  root_copy "etc/sysctl.d/99-idea.conf"
  root_copy "etc/systemd/system/getty@tty1.service.d/override.conf"
  root_copy "etc/systemd/system/reflector.service"
  root_copy "etc/systemd/system/reflector.timer"
  root_copy "etc/X11/xorg.conf.d/30-touchpad.conf"

  sudo sysctl --system

  sudo_systemd_enable_start "reflector.timer"
  sudo_systemd_enable_start "NetworkManager.service"
  sudo_systemd_enable_start "NetworkManager-wait-online.service"
  sudo_systemd_enable_start "dropbox@maximbaz"

  # tlp
  sudo_systemd_enable_start "tlp"
  sudo_systemd_enable_start "tlp-sleep"
  sudo_systemd_enable_start "NetworkManager-dispatcher.service"
  sudo systemctl mask "systemd-rfkill.service"
fi


if [ "$(whoami)" == "root"  ]; then
  create_link "$dotfiles_dir/.config/nvim/init.vim" "/root/.config/nvim/init.vim"
  create_link "/home/maximbaz/.cache/dein" "/root/.cache/dein"

  create_link "$dotfiles_dir/.agignore" "/root/.agignore"

  create_link "/home/maximbaz/.zprezto" "/root/.zprezto"
  create_link "$dotfiles_dir/.zpreztorc" "/root/.zpreztorc"
  create_link "$dotfiles_dir/.zsh" "/root/.zsh"
  create_link "$dotfiles_dir/.zsh.prompts" "/root/.zsh.prompts"
  create_link "$dotfiles_dir/.zshrc" "/root/.zshrc"
fi
