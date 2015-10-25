#!/bin/sh

reset=$1

if [ "$reset" != "" ]; then
  setxkbmap -layout "us"
else
  current="$(setxkbmap -query | grep layout | perl -pe 's/^layout: +([^ ]+)$/$1/')"
  if [ "$current" = "us" ] ; then
    setxkbmap -layout "ru"
  else
    setxkbmap -layout "us" -variant "us-da"
    if [ $? != 0 ]; then
      setxkbmap -layout "us"
    fi
  fi
fi

