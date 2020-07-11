#!/bin/bash

set -e
exec 2> >(while read line; do echo -e "\e[01;31m$line\e[0m"; done)

MY_GPG_KEY_ID="12C87A28FEAC6B20"

dotfiles_dir="$(
    cd "$(dirname "$0")"
    pwd
)"
cd "$dotfiles_dir"

link() {
    orig_file="$dotfiles_dir/$1"
    if [ -n "$2" ]; then
        dest_file="$HOME/$2"
    else
        dest_file="$HOME/$1"
    fi

    mkdir -p "$(dirname "$orig_file")"
    mkdir -p "$(dirname "$dest_file")"

    rm -rf "$dest_file"
    ln -s "$orig_file" "$dest_file"
    echo "$dest_file -> $orig_file"
}

is_chroot() {
    grep rootfs /proc/mounts > /dev/null
}

systemctl_enable_start() {
    echo "systemctl --user enable --now "$1""
    systemctl --user enable --now "$1"
}

echo "==========================="
echo "Setting up user dotfiles..."
echo "==========================="

link "bin"

link ".gitconfig.$(hostgroup)" ".gitconfig"
link ".gitconfig.common"
link ".gitignore"
link ".gnupg/gpg.conf"
link ".gtkrc-2.0"
link ".ignore"
link ".magic"
link ".mbsyncrc"
link ".notmuch-config"
link ".p10k.zsh"
link ".pylintrc"
link ".taskrc"
link ".xkb"
link ".zprofile"
link ".zsh-aliases"
link ".zshenv"
link ".zshrc"

link ".mozilla/firefox/profile/user.js"
link ".mozilla/firefox/profile/chrome"

link ".config/chromium-flags.conf"
link ".config/flashfocus"
link ".config/gsimplecal"
link ".config/gtk-3.0"
link ".config/htop"
link ".config/imapnotify"
link ".config/kak"
link ".config/kitty"
link ".config/mako"
link ".config/mimeapps.list"
link ".config/mpv"
link ".config/msmtp"
link ".config/neomutt"
link ".config/nnn/plugins"
link ".config/pacman"
link ".config/qalculate/qalc.cfg"
link ".config/qutebrowser"
link ".config/redshift"
link ".config/repoctl"
link ".config/swappy"
link ".config/sway"
link ".config/swaylock"
link ".config/systemd/user/backup-packages.service"
link ".config/systemd/user/backup-packages.timer"
link ".config/tig"
link ".config/transmission/settings.json"
link ".config/USBGuard"
link ".config/waybar"
link ".config/vimiv"
link ".config/wofi"

link ".gnupg/gpg-agent.conf"

link ".local/share/applications"
link ".local/share/qutebrowser/greasemonkey"

if is_chroot; then
    echo >&2 "=== Running in chroot, skipping user services..."
else
    echo ""
    echo "================================="
    echo "Enabling and starting services..."
    echo "================================="

    systemctl --user daemon-reload
    systemctl_enable_start "backup-packages.timer"
    systemctl_enable_start "redshift.service"
    systemctl_enable_start "wl-clipboard-manager.service"
    systemctl_enable_start "wluma.service"
    systemctl_enable_start "yubikey-touch-detector.service"

    if [[ $HOSTNAME == home-* ]]; then
        if [ -d "$HOME/.mail" ]; then
            systemctl_enable_start "goimapnotify@personal.service"
        else
            echo >&2 -e "
            === Mail is not configured, skipping...
            === Consult ~/.mbsyncrc for initial setup, and then sync everything using:
            === while ! mbsync -a; do echo 'restarting...'; done
            "
        fi
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
    echo >&2 "=== Running in chroot, skipping YubiKey configuration..."
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
    echo >&2 "=== Password store is not configured yet, skipping..."
fi

if is_chroot; then
    echo >&2 "=== Running in chroot, skipping GTK file chooser dialog configuration..."
else
    echo "Configuring GTK file chooser dialog"
    gsettings set org.gtk.Settings.FileChooser sort-directories-first true
fi

echo "Ignoring further changes to often changing config"
git update-index --assume-unchanged ".config/transmission/settings.json"

echo "Configure repo-local git settings"
git config user.email "git@maximbaz.com"
git config user.signingkey "8053EB88879A68CB4873D32B011FDC52DA839335"
git config commit.gpgsign true
git remote set-url origin "git@github.com:maximbaz/dotfiles.git"
