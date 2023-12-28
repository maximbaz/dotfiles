#!/bin/bash

build() {
    add_file /etc/systemd/system/asahi-firmware-preload.service
    add_file /etc/systemd/system/asahi-firmware-unpack.service

    add_symlink /etc/systemd/system/sysinit.target.wants/asahi-firmware-unpack.service ../asahi-firmware-unpack.service
    add_symlink /etc/systemd/system/initrd.target.wants/asahi-firmware-preload.service ../asahi-firmware-preload.service

    sed 's/new_root/sysroot/g' /usr/lib/initcpio/hooks/asahi > "${BUILDROOT}/hooks/sd-asahi-addon"
}

help() {
    cat << HELPEOF
This unpacks and preloads Asahi firmware during boot, when using systemd instead of udev hook.
Use *in addition* to asahi hook, not as a replacement.
HELPEOF
}

# vim: set ft=sh ts=4 sw=4 et:
