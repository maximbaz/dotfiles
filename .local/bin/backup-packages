#!/bin/bash

comm -23 <(pacman -Qqe | sort) <(for p in aarch64 base x86_64; do echo "maximbaz-$p"; done) > ~/.dotfiles/packages/unknown.list
pacman -Dk 2> ~/.dotfiles/packages/removed.list > /dev/null
pacman -Qdttq > ~/.dotfiles/packages/obsolete.list
exit 0
