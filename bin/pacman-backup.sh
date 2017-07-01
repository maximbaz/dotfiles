#!/usr/bin/env bash

comm -23 <(pacman -Qnqe | sort) <(pacman -Qgq base base-devel | sort) > ~/lib/pacman.native.list
pacman -Qmqe | sort > ~/lib/pacman.foreign.list
