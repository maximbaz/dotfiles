#!/bin/sh

# PARAMETERS
MONITOR=${1:-0}
MACHINE=${2:-CRMDevVM-0024}
USER=${3:-maximbaz}
DOMAIN=${4:-europe}

xfreerdp /f +fonts +aero +window-drag +menu-anims /bpp:32 /gdi:hw /gfx +gfx-progressive /sound:sys:pulse /microphone:sys:pulse +clipboard /cert-ignore +auto-reconnect /u:$USER /d:$DOMAIN /v:$MACHINE /monitors:$MONITOR

