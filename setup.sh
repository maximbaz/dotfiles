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

link ".emacs.d/init.el"
link ".emacs.d/custom.el"
link ".emacs.d/configs"
link ".emacs.d/snippets"

link ".i3/config"
link ".i3status.conf"

link ".ghc/ghci.conf"

link ".config/konsolerc"
link ".local/share/konsole"

link ".config/htop"

link ".compton.conf"
link ".gitconfig"
link ".tmux.conf"
link ".vimrc"
link ".yaourtrc"
link ".xinitrc"
link ".Xresources"
link ".zsh"
link ".zshrc"

link "dircolors.256dark"

link ".config/synapse"

