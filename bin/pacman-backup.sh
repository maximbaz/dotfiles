#!/usr/bin/env bash

pacman -Qnqe > ~/lib/pacman.native.list
pacman -Qmqe > ~/lib/pacman.foreign.list
