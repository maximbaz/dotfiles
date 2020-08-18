#!/bin/sh

marker="/tmp/waybar-dnd"

show() {
    if [ -e "$marker" ]; then
        printf '{"text": "  ", "class": "on"}\n'
    else
        printf '{"text": "  ", "class": "off"}\n'
    fi
}

toggle() {
    if [ -e "$marker" ]; then
        makoctl set invisible=false
        rm -f "$marker"
    else
        makoctl set invisible=true
        touch "$marker"
    fi
    pkill -RTMIN+2 -x waybar
}

[ $# -gt 0 ] && toggle || show
