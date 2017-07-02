#!/usr/bin/env zsh

if [[ "$1" != "native" && "$1" != "foreign" ]]; then
  echo "Usage: $0 <native|foreign>"
  exit 1
fi

zmodload -ap zsh/mapfile mapfile
packages=( ${(f)mapfile[/home/maximbaz/lib/pacman.$1.list]} )

if [[ "$1" == "native" ]]; then
  sudo pacman -Sy "$packages[@]"
else
  yay -S "$packages[@]"
fi
