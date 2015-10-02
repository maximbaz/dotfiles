#!/bin/sh

DIR=$( cd "$( dirname "$(readlink -f "$0")" )" && pwd )

ln -s $DIR/tmux.conf ~/.tmux.conf
ln -s $DIR/gitconfig ~/.gitconfig

