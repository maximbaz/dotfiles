#!/bin/sh

CURRENT="$(setxkbmap -query | grep layout | perl -pe 's/^layout: +([^ ]+)$/$1/')"

if [ "$CURRENT" = "us" ] ; then
    setxkbmap -layout "ru"
else
    setxkbmap -layout "us"
    # -variant "us-da"
fi

