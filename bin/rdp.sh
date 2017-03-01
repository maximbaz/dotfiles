#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $DIR/rdp.conf

xfreerdp /f /fonts /aero /window-drag /menu-anims /bpp:32 /gdi:sw /gfx /gfx-progressive /sound:sys:pulse /clipboard /cert-ignore /auto-reconnect /auto-reconnect-max-retries:3 /u:$USER /d:$DOMAIN /v:$MACHINE /p:$PASSWORD
