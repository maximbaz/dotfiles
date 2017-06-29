#!/bin/bash

dotfiles_dir="$(dirname $0)"

link() {
  create_link "$dotfiles_dir/$1" "$HOME/$1"
}

root_link() {
  sudo bash -c "$(declare -f create_link); $(declare -f path); create_link "$dotfiles_dir/$1" "/$1""
}

create_link() {
  set -e

  real_file="$(path "$1")"
  link_file="$(path "$2")"

  rm -rf $link_file
  ln -s $real_file $link_file

  echo "$real_file <-> $link_file"
}

path() {
  mkdir -p "$(dirname "$1")"
  echo "$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
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
  link ".config/sakura"
  link ".config/systemd/user/tmux.service"
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

  root_link "etc/private-internet-access/pia.conf"
fi


if [ "$(whoami)" == "root"  ]; then
  create_link "/home/maximbaz/.config/nvim/init.vim" "/root/.config/nvim/init.vim"

  create_link "$dotfiles_dir/.agignore" "/root/.agignore"

  create_link "/home/maximbaz/.zprezto" "/root/.zprezto"
  create_link "$dotfiles_dir/.zpreztorc" "/root/.zpreztorc"
  create_link "$dotfiles_dir/.zsh" "/root/.zsh"
  create_link "$dotfiles_dir/.zsh.prompts" "/root/.zsh.prompts"
  create_link "$dotfiles_dir/.zshrc" "/root/.zshrc"
fi
