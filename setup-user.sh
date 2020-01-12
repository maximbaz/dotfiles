#!/bin/bash

set -e
exec 2> >(while read line; do echo -e "\e[01;31m$line\e[0m"; done)

MY_GPG_KEY_ID="12C87A28FEAC6B20"

dotfiles_dir="$(cd "$(dirname "$0")"; pwd)"
cd "$dotfiles_dir"

link() {
    orig_file="$dotfiles_dir/$1"
    dest_file="$HOME/$1"

    mkdir -p "$(dirname "$orig_file")"
    mkdir -p "$(dirname "$dest_file")"

    rm -rf "$dest_file"
    ln -s "$orig_file" "$dest_file"
    echo "$dest_file -> $orig_file"
}

is_chroot() {
    grep rootfs /proc/mounts >/dev/null
}

systemctl_enable_start() {
    echo "systemctl --user enable --now "$1""
    systemctl --user enable --now "$1"
}

echo "==========================="
echo "Setting up user dotfiles..."
echo "==========================="

link "bin"

link ".gitconfig"
link ".gitconfig.work"
link ".gitignore"
link ".gnupg/gpg.conf"
link ".gtkrc-2.0"
link ".ignore"
link ".magic"
link ".mbsyncrc"
link ".notmuch-config"
link ".opensnitch"
link ".pylintrc"
link ".taskrc"
link ".Xmodmap"
link ".Xresources"
link ".xsession"
link ".zsh"
link ".zshrc"

link ".config/chromium-flags.conf"
link ".config/copyq/copyq.conf"
link ".config/Dharkael"
link ".config/dunst"
link ".config/gsimplecal"
link ".config/gtk-3.0"
link ".config/htop"
link ".config/i3"
link ".config/imapnotify"
link ".config/kak"
link ".config/kitty"
link ".config/mimeapps.list"
link ".config/mpv/mpv.conf"
link ".config/msmtp"
link ".config/neomutt"
link ".config/networkmanager-dmenu"
link ".config/nnn/plugins"
link ".config/pacman"
link ".config/picom/picom.conf"
link ".config/py3status"
link ".config/qalculate/qalc.cfg"
link ".config/ranger/rc.conf"
link ".config/redshift"
link ".config/repoctl"
link ".config/rofi"
link ".config/systemd/user/backup-packages.service"
link ".config/systemd/user/backup-packages.timer"
link ".config/systemd/user/mbsync.service"
link ".config/systemd/user/mbsync.timer"
link ".config/tig"
link ".config/transmission/settings.json"
link ".config/urlwatch"
link ".config/USBGuard"
link ".config/vifm/vifmrc"
link ".config/vimiv"

link ".gnupg/gpg-agent.conf"
link ".gnupg/pinentry-dmenu.conf"

link ".local/share/applications/neomutt.desktop"
link ".local/share/fonts/taskbar.ttf"

if is_chroot; then
    >&2 echo "=== Running in chroot, skipping user services..."
else
    echo ""
    echo "================================="
    echo "Enabling and starting services..."
    echo "================================="

    systemctl --user daemon-reload
    systemctl_enable_start "backup-packages.timer"
    systemctl_enable_start "dunst.service"
    systemctl_enable_start "redshift.service"
    systemctl_enable_start "yubikey-touch-detector.service"

    if [ -d "$HOME/.mail" ]; then
        systemctl_enable_start "mbsync.timer"
        systemctl_enable_start "goimapnotify@personal.service"
    else
        >&2 echo -e "
        === Mail is not configured, skipping...
        === Consult ~/.mbsyncrc for initial setup, and then sync everything using:
        === while ! mbsync -a; do echo 'restarting...'; done
        "
    fi
fi

echo ""
echo "======================================="
echo "Finishing various user configuration..."
echo "======================================="

echo "Configuring MIME types"
file --compile --magic-file "$HOME/.magic"

if ! gpg -k | grep "$MY_GPG_KEY_ID" > /dev/null; then
    echo "Importing my public PGP key"
    curl -s https://maximbaz.com/pgp_keys.asc | gpg --import
    gpg --trusted-key "$MY_GPG_KEY_ID" > /dev/null
fi

find "$HOME/.gnupg" -type f -not -path "*#*" -exec chmod 600 {} \;
find "$HOME/.gnupg" -type d -exec chmod 700 {} \;

if is_chroot; then
    >&2 echo "=== Running in chroot, skipping YubiKey configuration..."
else
    if [ ! -s "$HOME/.config/Yubico/u2f_keys" ]; then
        echo "Configuring YubiKey for passwordless sudo (touch it now)"
        mkdir -p "$HOME/.config/Yubico"
        pamu2fcfg -umaximbaz > "$HOME/.config/Yubico/u2f_keys"
    fi
fi

if [ -d "$HOME/.password-store" ]; then
    echo "Configuring automatic git push for pass"
    echo -e "#!/bin/sh\n\npass git push" > "$HOME/.password-store/.git/hooks/post-commit"
    chmod +x "$HOME/.password-store/.git/hooks/post-commit"
else
    >&2 echo "=== Password store is not configured yet, skipping..."
fi

echo "Configuring GTK file chooser dialog"
gsettings set org.gtk.Settings.FileChooser sort-directories-first true

echo "Ignoring further changes to often changing config"
git update-index --assume-unchanged ".config/transmission/settings.json"
