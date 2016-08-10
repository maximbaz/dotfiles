#!/bin/sh

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

link "bin"
link "lib"

link ".emacs.d/init.el"
link ".emacs.d/custom.el"
link ".emacs.d/configs"
link ".emacs.d/snippets"

link ".i3/config"
link ".i3status.conf"

link ".ghc/ghci.conf"

link ".config/albert/albert.conf"
link ".config/copyq/copyq.conf"
link ".config/dunst"
link ".config/gsimplecal"
link ".config/gtk-3.0"
link ".config/htop"
link ".config/kalu"
link ".config/ranger/rc.conf"
link ".config/sakura"

link ".compton.conf"
link ".gitconfig"
link ".gtkrc-2.0"
link ".pylintrc"
link ".tigrc"
link ".tmux.conf"
link ".vimrc"
link ".xinitrc"
link ".Xresources"
link ".yaourtrc"
link ".zprofile"
link ".zsh"
link ".zshrc"

create_link "$HOME/.vim" "$HOME/.config/nvim"
create_link "$HOME/.vimrc" "$HOME/.config/nvim/init.vim"

link "dircolors.256dark"

