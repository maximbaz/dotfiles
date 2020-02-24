#!/bin/bash

set -e
exec 2> >(while read line; do echo -e "\e[01;31m$line\e[0m"; done)

script_name="$(basename "$0")"
dotfiles_dir="$(cd "$(dirname "$0")"; pwd)"
cd "$dotfiles_dir"

if (( "$EUID" )); then
    sudo -s "$dotfiles_dir/$script_name" "$@"
    exit 0
fi

if [ "$1" = "-r" ]; then
    >&2 echo "Running in reverse mode!"
    reverse=1
fi

copy() {
    if [ -z "$reverse" ]; then
        orig_file="$dotfiles_dir/$1"
        dest_file="/$1"
    else
        orig_file="/$1"
        dest_file="$dotfiles_dir/$1"
    fi

    mkdir -p "$(dirname "$orig_file")"
    mkdir -p "$(dirname "$dest_file")"

    rm -rf "$dest_file"

    cp -R "$orig_file" "$dest_file"
    if [ -z "$reverse" ]; then
        [ -n "$2" ] && chmod "$2" "$dest_file"
    else
        chown -R maximbaz "$dest_file"
    fi
    echo "$dest_file <= $orig_file"
}

is_chroot() {
    grep rootfs /proc/mounts >/dev/null
}

systemctl_enable() {
    echo "systemctl enable "$1""
    systemctl enable "$1"
}

systemctl_enable_start() {
    echo "systemctl enable --now "$1""
    systemctl enable "$1"
    systemctl start  "$1"
}

echo ""
echo "=========================="
echo "Setting up /etc configs..."
echo "=========================="

copy "etc/bluetooth/main.conf"
copy "etc/conf.d/snapper"
copy "etc/default/grub-btrfs/config"
copy "etc/docker/daemon.json"
copy "etc/environment"
copy "etc/knot-resolver/kresd.conf"
copy "etc/NetworkManager/conf.d"
copy "etc/NetworkManager/dispatcher.d/pia-vpn"
copy "etc/pacman.conf"
copy "etc/pacman.d/hooks"
copy "etc/pam.d/sudo"
copy "etc/pulse/default.pa"
copy "etc/profile.d/zz_custom.sh"
copy "etc/snap-pac.conf"
copy "etc/snapper/configs/root"
copy "etc/ssh/ssh_config"
copy "etc/sudoers"
copy "etc/sysctl.d/10-swappiness.conf"
copy "etc/sysctl.d/99-sysctl.conf"
copy "etc/systemd/journald.conf"
copy "etc/systemd/logind.conf"
copy "etc/systemd/network"
copy "etc/systemd/system/backup-repo@pkgbuild"
copy "etc/systemd/system/backup-repo@.service"
copy "etc/systemd/system/getty@tty2.service.d/override.conf"
copy "etc/systemd/system/iwd.service.d/90-networkmanager.conf"
copy "etc/systemd/system/usbguard.service.d/override.conf"
copy "etc/systemd/system/paccache.service"
copy "etc/systemd/system/paccache.timer"
copy "etc/systemd/system/reflector.service"
copy "etc/systemd/system/reflector.timer"
copy "etc/systemd/system/system-dotfiles-sync.service"
copy "etc/systemd/system/system-dotfiles-sync.timer"
copy "etc/udev/rules.d/81-ac-battery-change.rules"
copy "etc/updatedb.conf"
copy "etc/usbguard/usbguard-daemon.conf" 600

(( "$reverse" )) && exit 0

echo ""
echo "================================="
echo "Enabling and starting services..."
echo "================================="

sysctl --system > /dev/null

systemctl daemon-reload
systemctl_enable "backup-repo@pkgbuild.service"
systemctl_enable "getty@tty2.service"
systemctl_enable_start "bluetooth.service"
systemctl_enable_start "btrfs-scrub@-.timer"
systemctl_enable_start "btrfs-scrub@mnt-btrfs\x2droot.timer"
systemctl_enable_start "btrfs-scrub@home.timer"
systemctl_enable_start "btrfs-scrub@var-cache-pacman.timer"
systemctl_enable_start "btrfs-scrub@var-log.timer"
systemctl_enable_start "btrfs-scrub@var-tmp.timer"
systemctl_enable_start "btrfs-scrub@\x2esnapshots.timer"
systemctl_enable_start "docker.service"
systemctl_enable_start "fstrim.timer"
systemctl_enable_start "iwd.service"
systemctl_enable_start "kresd@1.service"
systemctl_enable_start "linux-modules-cleanup.service"
systemctl_enable_start "paccache.timer"
systemctl_enable_start "pcscd.service"
systemctl_enable_start "reflector.timer"
systemctl_enable_start "snapper-cleanup.timer"
systemctl_enable_start "system-dotfiles-sync.timer"
systemctl_enable_start "systemd-networkd.service"
systemctl_enable_start "systemd-resolved.service"
systemctl_enable_start "teamviewerd.service"
systemctl_enable_start "tlp.service"
systemctl_enable_start "tlp-sleep.service"
systemctl_enable_start "ufw.service"
systemctl_enable_start "usbguard.service"
systemctl_enable_start "usbguard-dbus.service"

if [ ! -s "/etc/usbguard/rules.conf" ]; then
    >&2 echo "=== Remember to set usbguard rules: usbguard generate-policy >! /etc/usbguard/rules.conf"
fi

if [ -d "/home/maximbaz/.ccnet" ]; then
    systemctl_enable_start "seaf-cli@maximbaz.service"
else
    >&2 echo "=== Seafile is not initialized, skipping..."
fi

echo ""
echo "==============================="
echo "Creating top level Trash dir..."
echo "==============================="
mkdir --parent /.Trash
chmod a+rw /.Trash
chmod +t /.Trash
echo "Done"

echo ""
echo "======================================="
echo "Finishing various user configuration..."
echo "======================================="

echo "Configuring /etc/resolv.conf"
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

echo "Configuring aurutils"
ln -sf /etc/pacman.conf /usr/share/devtools/pacman-aur.conf
ln -sf /usr/bin/archbuild /usr/local/bin/aur-x86_64-build

echo "Configuring fontconfig"
ln -sf /etc/fonts/conf.avail/75-joypixels.conf /etc/fonts/conf.d/75-joypixels.conf

if is_chroot; then
    >&2 echo "=== Running in chroot, skipping firewall and udev setup..."
else
    echo "Configuring firewall"
    ufw --force reset >/dev/null
    ufw default allow outgoing
    ufw default deny incoming
    ufw enable
    find /etc/ufw -type f -name '*.rules.*' -delete

    echo "Reload udev rules"
    udevadm control --reload
    udevadm trigger

    sleep 1
fi
