#!/usr/bin/env bash

sessions=$(tmux ls | grep '^[0-9]\+:' | cut -f1 -d':' | sort)

new=1
for old in $sessions
do
  tmux rename -t $old $new
  ((new++))
done
