#!/usr/bin/env bash

comm -23 <(pacman -Qnqe | sort) <(pacman -Qgq base base-devel | sort) > ~/.dotfiles/packages/pacman.list
