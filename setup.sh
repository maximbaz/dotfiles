#!/bin/sh

path() {
  mkdir -p "$(dirname "$1")"
  echo "$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
}

dotfiles_dir="$(dirname $0)"

link() {
  real_file="$(path "$dotfiles_dir/$1")"
  link_file="$(path "$HOME/$1")"

  rm -f $link_file
  ln -s $real_file $link_file

  echo "$real_file <-> $link_file"
}

link ".tmux.conf"
link ".gitconfig"

link ".emacs.d/init.el"
link ".emacs.d/custom.el"
link ".emacs.d/configs"
link ".emacs.d/snippets"

