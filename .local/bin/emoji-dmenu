#!/bin/sh

data="${XDG_CACHE_HOME:-$HOME/.cache}/emoji.data"
[ -f "$data" ] || {
    notify-send "emoji-dmenu" "Bootstrapping emojis, please wait..."
    emoji-bootstrap
}

line="$(cat "$data" | dmenu -p emoji)"

if [ -n "$line" ]; then
    sed -i "/$line/d" "$data"
    sed -i "1s;^;$line\n;;" "$data"

    wl-clipboard-manager lock
    printf '%s' "$line" | cut -d' ' -f1 | tr -d '\n' | wl-copy
    wl-clipboard-manager unlock
fi
