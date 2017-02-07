#!/bin/bash

path() {
  mkdir -p "$(dirname "$1")"
  echo "$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
}

dotfiles_dir="$(dirname $0)"

link() {
  create_link "$dotfiles_dir/$1" "$HOME/$1"
}

create_link() {
  real_file="$(path "$1")"
  link_file="$(path "$2")"

  rm -rf $link_file
  ln -s $real_file $link_file

  echo "$real_file <-> $link_file"
}

if [ "$(whoami)" != "root"  ]; then
  link "bin"
  link "lib"

  link ".i3/config"
  link ".i3status.conf"

  link ".ghc/ghci.conf"

  link ".config/Cerebro/config.json"
  link ".config/copyq/copyq.conf"
  link ".config/dunst"
  link ".config/gsimplecal"
  link ".config/gtk-3.0"
  link ".config/htop"
  link ".config/kalu"
  link ".config/mpv/mpv.conf"
  link ".config/nvim/init.vim"
  link ".config/ranger/rc.conf"
  link ".config/redshift.conf"
  link ".config/sakura"

  link ".compton.conf"
  link ".gitconfig"
  link ".gtkrc-2.0"
  link ".notify-osd"
  link ".pylintrc"
  link ".tigrc"
  link ".tmux.conf"
  link ".xinitrc"
  link ".Xresources"
  link ".yaourtrc"
  link ".zlogin"
  link ".zpreztorc"
  link ".zprofile"
  link ".zsh"
  link ".zsh.prompts"
  link ".zshenv"
  link ".zshrc"
fi


if [ "$(whoami)" == "root"  ]; then
  create_link "/home/maximbaz/.config/nvim/init.vim" "/root/.config/nvim/init.vim"

  create_link "/home/maximbaz/.zprezto" "/root/.zprezto"
  create_link "$dotfiles_dir/.zlogin" "/root/.zlogin"
  create_link "$dotfiles_dir/.zpreztorc" "/root/.zpreztorc"
  create_link "$dotfiles_dir/.zsh" "/root/.zsh"
  create_link "$dotfiles_dir/.zsh.prompts" "/root/.zsh.prompts"
  create_link "$dotfiles_dir/.zshenv" "/root/.zshenv"
  create_link "$dotfiles_dir/.zshrc" "/root/.zshrc"
fi

