#!/bin/bash

set -e
exec 2> >(while read line; do echo -e "\e[01;31m$line\e[0m"; done)

script_name="$(basename "$0")"
dotfiles_dir="$(
    cd "$(dirname "$0")"
    pwd
)"
cd "$dotfiles_dir"

if (("$EUID")); then
    sudo -s "$dotfiles_dir/$script_name" "$@"
    exit 0
fi

if [ "$1" = "-r" ]; then
    echo >&2 "Running in reverse mode!"
    reverse=1
fi

copy() {
    if [ -z "$reverse" ]; then
        orig_file="$dotfiles_dir/$1"
        [ -n "$3" ] && dest_file="/$3" || dest_file="/$1"
    else
        [ -n "$3" ] && orig_file="/$3" || orig_file="/$1"
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
    ! cmp -s /proc/1/mountinfo /proc/self/mountinfo
}

systemctl_enable() {
    echo "systemctl enable "$1""
    systemctl enable "$1"
}

systemctl_enable_start() {
    echo "systemctl enable --now "$1""
    systemctl enable "$1"
    systemctl start "$1"
}

echo ""
echo "=========================="
echo "Setting up reverse sync..."
echo "=========================="

if [ -z "$reverse" ]; then
    printf "#!/bin/sh\n$0 -r\n" > /usr/local/bin/system-dotfiles-sync
    chmod +x /usr/local/bin/system-dotfiles-sync
    echo "Done"
else
    echo "Skipped in reverse mode"
fi

echo ""
echo "=========================="
echo "Setting up /etc configs..."
echo "=========================="

copy "etc/crypttab"
copy "etc/default/earlyoom"
copy "etc/fstab"
copy "etc/iwd/main.conf"
copy "etc/modprobe.d/hid_apple.conf"
copy "etc/pam.d/polkit-1"
copy "etc/pam.d/sudo"
copy "etc/ssh/ssh_config"
copy "etc/sudoers.d/override"
copy "etc/sysctl.d/10-sysrq.conf"
copy "etc/sysconfig/nftables.conf"
copy "etc/sysconfig/update-m1n1"
copy "etc/systemd/journald.conf.d/override.conf"
copy "etc/systemd/logind.conf.d/override.conf"
copy "etc/systemd/network/20-wireless.network"
copy "etc/systemd/network/50-wired.network"
copy "etc/systemd/resolved.conf.d/global.conf"
copy "etc/systemd/system/getty@tty1.service.d/override.conf"
copy "etc/systemd/system/usbguard.service.d/override.conf"
copy "etc/systemd/system/system-dotfiles-sync.service"
copy "etc/systemd/system/system-dotfiles-sync.timer"
copy "etc/systemd/system.conf.d/kill-fast.conf"
copy "etc/udev/rules.d/50-usb_yubikey_power_save.rules"
copy "etc/udisks2/mount_options.conf"
copy "etc/usbguard/usbguard-daemon.conf" 600
copy "etc/vconsole.conf"

(("$reverse")) && exit 0

echo ""
echo "================================="
echo "Enabling and starting services..."
echo "================================="

sysctl --system > /dev/null

systemctl daemon-reload
systemctl_enable_start "bluetooth.service"
systemctl_enable_start "earlyoom.service"
systemctl_enable_start "fstrim.timer"
systemctl_enable_start "iwd.service"
systemctl_enable_start "nftables.service"
systemctl_enable_start "pcscd.socket"
systemctl_enable_start "system-dotfiles-sync.timer"
systemctl_enable_start "systemd-networkd.socket"
systemctl_enable_start "systemd-resolved.service"
systemctl_enable_start "tlp.service"

if [ ! -s "/etc/usbguard/rules.conf" ]; then
    echo >&2 "=== Remember to set usbguard rules: usbguard generate-policy >! /etc/usbguard/rules.conf"
else
    chmod 600 /etc/usbguard/rules.conf
    systemctl_enable_start "usbguard.service"
    systemctl_enable_start "usbguard-dbus.service"
fi

echo ""
echo "===================="
echo "Reload udev rules..."
echo "===================="
udevadm control --reload
udevadm trigger

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

if is_chroot; then
    echo >&2 "=== Running in chroot, skipping /etc/resolv.conf setup..."
else
    echo "Configuring /etc/resolv.conf"
    ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
fi

echo "Configuring NTP"
timedatectl set-ntp true
