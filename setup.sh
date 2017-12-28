#!/bin/zsh

set -e

script_name="$(basename "$0")"
dotfiles_dir="$(cd "$(dirname "$0")"; pwd)"
cd "$dotfiles_dir"

assign() {
  op="$1"
  if [[ "$op" != "link" && "$op" != "copy" ]]; then
    echo "Unknown operation: $op"
    exit 1
  fi

  orig_file="$2"
  dest_file="$3"

  mkdir -p "$(dirname "$orig_file")"
  mkdir -p "$(dirname "$dest_file")"

  rm -rf "$dest_file"

  if [[ "$op" == "link" ]]; then
    ln -s "$orig_file" "$dest_file"
    echo "$dest_file -> $orig_file"
  else
    cp -R "$orig_file" "$dest_file"
    echo "$dest_file <= $orig_file"
  fi
}

link() {
  assign "link" "$dotfiles_dir/$1" "$HOME/$1"
}

copy() {
  assign "copy" "$dotfiles_dir/$1" "/$1"
}

systemctl_enable_start() {
  if [ "$#" -eq 1 ]; then
    target="system"
    name="$1"
  else
    target="$1"
    name="$2"
  fi
  if [[ "$target" == "user" ]]; then
    echo "systemctl --user enable & start "$name""
    systemctl --user enable "$name"
    systemctl --user start  "$name"
  else
    echo "systemctl enable & start "$name""
    systemctl enable "$name"
    systemctl start  "$name"
  fi
}


if [ "$(whoami)" != "root" ]; then
  echo "======================================="
  echo "Setting up dotfiles for current user..."
  echo "======================================="

  link "bin"

  link ".ghc/ghci.conf"
  link ".gnupg/gpg.conf"

  link ".config/htop"
  link ".config/nvim/init.vim"
  link ".config/ranger/rc.conf"
  link ".config/yay/config.json"

  link ".config/systemd/user/backup-packages.service"
  link ".config/systemd/user/backup-packages.timer"

  link ".agignore"
  link ".gitconfig"
  link ".gitignore"
  link ".npmrc"
  link ".pylintrc"
  link ".tigrc"
  link ".tmux.conf"
  link ".zprofile"
  link ".zsh"
  link ".zshrc"

  if [[ "$HOST" =~ "desktop-" ]]; then
    link ".i3/config"
    link ".i3status.conf"

    link ".gnupg/gpg-agent.conf"

    link ".config/alacritty/alacritty.yml"
    link ".config/Cerebro/config.json"
    link ".config/chromium-flags.conf"
    link ".config/copyq/copyq.conf"
    link ".config/dunst"
    link ".config/fontconfig/conf.d/30-infinality-custom.conf"
    link ".config/fontconfig/conf.d/70-monospace.conf"
    link ".config/gsimplecal"
    link ".config/gtk-3.0"
    link ".config/mpv/mpv.conf"
    link ".config/redshift.conf"
    link ".config/TheHive"
    link ".config/transmission/settings.json"

    link ".config/systemd/user/tmux.service"
    link ".config/systemd/user/urlwatch.service"
    link ".config/systemd/user/urlwatch.timer"

    link ".local/share/fonts"

    link ".compton.conf"
    link ".gtkrc-2.0"
    link ".urlwatch/urls.yaml"
    link ".xinitrc"
    link ".Xresources"
  fi

  echo ""
  echo "================================="
  echo "Enabling and starting services..."
  echo "================================="

  systemctl --user daemon-reload
  systemctl_enable_start "user" "backup-packages.timer"

  if [[ "$HOST" =~ "desktop-" ]]; then
    systemctl_enable_start "user" "dunst.service"
    systemctl_enable_start "user" "tmux.service"
    systemctl_enable_start "user" "redshift.service"
    systemctl_enable_start "user" "urlwatch.timer"
    systemctl_enable_start "user" "yubikey-touch-detector.service"
  fi

  echo ""
  echo "======================================="
  echo "Finishing various user configuration..."
  echo "======================================="

  if ! gpg -k | grep 12C87A28FEAC6B20 > /dev/null; then
    echo "Importing my public PGP key"
    curl -s https://keybase.io/maximbaz/pgp_keys.asc| gpg --import
    gpg --trusted-key 12C87A28FEAC6B20 > /dev/null
  fi

  if [[ "$HOST" =~ "desktop-" ]]; then
    if [[ ! -a "$HOME/.config/Yubico" ]]; then
      echo "Configuring YubiKey for sudo access (touch it now)"
      mkdir -p "$HOME/.config/Yubico"
      pamu2fcfg -umaximbaz > "$HOME/.config/Yubico/u2f_keys"
    fi
    echo "Disabling Dropbox autoupdate"
    rm -rf ~/.dropbox-dist
    install -dm0 ~/.dropbox-dist

    echo "Ignoring further changes to often changing config"
    git update-index --assume-unchanged ".config/TheHive/HotShots.conf"
    git update-index --assume-unchanged ".config/transmission/settings.json"
    git update-index --assume-unchanged ".config/Cerebro/config.json"
  fi

  echo ""
  echo "====================================="
  echo "Switching to root user to continue..."
  echo "====================================="
  echo "..."
  sudo -s "$dotfiles_dir/$script_name"
  exit
fi


if [[ "$(whoami)" == "root" ]]; then
  echo ""
  echo "=========================="
  echo "Setting up /etc configs..."
  echo "=========================="

  copy "etc/ssh/ssh_config"
  copy "etc/sysctl.d/10-swappiness.conf"
  copy "etc/sysctl.d/99-idea.conf"
  copy "etc/sysctl.d/99-sysctl.conf"
  copy "etc/systemd/system/paccache.service"
  copy "etc/systemd/system/paccache.timer"
  copy "etc/systemd/system/reflector.service"
  copy "etc/systemd/system/reflector.timer"
  copy "etc/updatedb.conf"

  if [[ "$HOST" =~ "desktop-" ]]; then
    copy "etc/NetworkManager/dispatcher.d/pia-vpn"
    copy "etc/private-internet-access/pia.conf"
    copy "etc/systemd/system/getty@tty1.service.d/override.conf"
    copy "etc/udev/rules.d/81-ac-battery-change.rules"
    copy "etc/X11/xorg.conf.d/30-touchpad.conf"
  fi

  if [[ "$HOST" =~ "crmdevvm-" ]]; then
    copy "etc/systemd/system/reverse-ssh@devbox"
    copy "etc/systemd/system/reverse-ssh@.service"
  fi

  echo ""
  echo "================================="
  echo "Enabling and starting services..."
  echo "================================="

  sysctl --system > /dev/null

  systemctl daemon-reload
  systemctl_enable_start "system" "paccache.timer"
  systemctl_enable_start "system" "reflector.timer"
  systemctl_enable_start "system" "NetworkManager.service"
  systemctl_enable_start "system" "NetworkManager-wait-online.service"
  systemctl_enable_start "system" "docker.service"
  systemctl_enable_start "system" "ufw.service"

  if [[ "$HOST" =~ "desktop-" ]]; then
    systemctl_enable_start "system" "dropbox@maximbaz.service"
    systemctl_enable_start "system" "pcscd.service"

    # tlp
    systemctl_enable_start "system" "tlp.service"
    systemctl_enable_start "system" "tlp-sleep.service"
    systemctl_enable_start "system" "NetworkManager-dispatcher.service"
    systemctl mask "systemd-rfkill.service"
  fi

  if [[ "$HOST" =~ "crmdevvm-" ]]; then
    systemctl_enable_start "system" "sshd.socket"
    systemctl_enable_start "system" "reverse-ssh@devbox.service"
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

  echo "Setting limit to journal logs size"
  sed -i "s/#\?\(SystemMaxUse\)=.*/\1=300M/" /etc/systemd/journald.conf

  echo "Enabling various pacman options"
  sed -i "s/#\?\(Color\)/\1/" /etc/pacman.conf
  sed -i "s/#\?\(TotalDownload\)/\1/" /etc/pacman.conf

  echo "Configuring makepkg"
  sed -i "s|#\?\(BUILDDIR\)=.*|\1=/tmp/makepkg|" /etc/makepkg.conf

  echo "Configuring firewall"
  [[ "$(ufw status | grep -o '[^ ]\+$')" != "active" ]] && ufw --force reset > /dev/null
  ufw default reject
  [[ "$HOST" =~ "crmdevvm-" ]] && ufw allow ssh
  ufw enable
  find /etc/ufw -type f -name '*.rules.*' -delete

  if [[ "$HOST" =~ "desktop-" ]]; then
    echo "Allowing to use U2F for sudo access"
    sed -zi "s|\(#%PAM-1.0\)\n\(auth    sufficient    pam_u2f.so    cue\n\)\?|\1\nauth    sufficient    pam_u2f.so    cue\n|" /etc/pam.d/sudo

    echo "Disable caching sudo access"
    sed -zi "s|\(## Defaults specification\n[^\n]*\n[^\n]*\n[^\n]*\n\)\(\nDefaults timestamp_timeout=0\n\n\)\?|\1\nDefaults timestamp_timeout=0\n\n|" /etc/sudoers

    echo "Configuring login manager"
    sed -i "s/#\?\(HandleLidSwitch\)=.*/\1=ignore/" /etc/systemd/logind.conf
    sed -i "s/#\?\(HandlePowerKey\)=.*/\1=ignore/" /etc/systemd/logind.conf

    echo "Enabling infinality aliases"
    ln -sf /etc/fonts/conf.avail/30-infinality-aliases.conf /etc/fonts/conf.d/30-infinality-aliases.conf
  fi

  if [[ "$HOST" =~ "crmdevvm-" ]]; then
    echo "Configuring gpg-agent forwarding"
    sed -zi "s/\(VersionAddendum[^\n]*\n\)\(StreamLocalBindUnlink[^\n]*\n\)\?/\1StreamLocalBindUnlink yes\n/" /etc/ssh/sshd_config
  fi

  echo "Reload udev rules"
  udevadm control --reload
  udevadm trigger
fi
