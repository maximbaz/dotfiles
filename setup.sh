#!/bin/sh

path() {
  mkdir -p "$(dirname "$1")"
  echo "$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
}

dotfiles_dir="$(dirname $0)"

link() {
  real_file="$(path "$dotfiles_dir/$1")"
  link_file="$(path "$HOME/$1")"

  rm -rf $link_file
  ln -s $real_file $link_file

  echo "$real_file <-> $link_file"
}

link "bin"
link "lib"

link ".emacs.d/init.el"
link ".emacs.d/custom.el"
link ".emacs.d/configs"
link ".emacs.d/snippets"

link ".i3/config"
link ".i3status.conf"

link ".ghc/ghci.conf"

link ".config/gsimplecal"
link ".config/htop"
link ".config/dunst"
link ".config/kalu"
link ".config/synapse"
link ".config/ranger/rc.conf"

link ".compton.conf"
link ".gitconfig"
link ".tmux.conf"
link ".tigrc"
link ".vimrc"
link ".yaourtrc"
link ".xinitrc"
link ".Xresources"
link ".zlogin"
link ".zsh"
link ".zshrc"

link "dircolors.256dark"

