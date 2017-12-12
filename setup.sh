#!/bin/bash

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

  link ".i3/config"
  link ".i3status.conf"

  link ".ghc/ghci.conf"
  link ".gnupg/gpg.conf"
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
  link ".config/htop"
  link ".config/mpv/mpv.conf"
  link ".config/nvim/init.vim"
  link ".config/ranger/rc.conf"
  link ".config/redshift.conf"
  link ".config/TheHive"
  link ".config/transmission/settings.json"
  link ".config/yay/config.json"

  link ".config/systemd/user/tmux.service"
  link ".config/systemd/user/backup-packages.service"
  link ".config/systemd/user/backup-packages.timer"
  link ".config/systemd/user/urlwatch.service"
  link ".config/systemd/user/urlwatch.timer"

  link ".local/share/fonts"

  link ".agignore"
  link ".compton.conf"
  link ".gitconfig"
  link ".gitignore"
  link ".gtkrc-2.0"
  link ".npmrc"
  link ".pylintrc"
  link ".tigrc"
  link ".tmux.conf"
  link ".urlwatch/urls.yaml"
  link ".xinitrc"
  link ".Xresources"
  link ".zprofile"
  link ".zsh"
  link ".zshrc"

  echo ""
  echo "================================="
  echo "Enabling and starting services..."
  echo "================================="

  systemctl_enable_start "user" "dunst.service"
  systemctl_enable_start "user" "tmux.service"
  systemctl_enable_start "user" "backup-packages.timer"
  systemctl_enable_start "user" "redshift.service"
  systemctl_enable_start "user" "urlwatch.timer"

  echo ""
  echo "======================================="
  echo "Finishing various user configuration..."
  echo "======================================="

  echo "Disabling Dropbox autoupdate"
  rm -rf ~/.dropbox-dist
  install -dm0 ~/.dropbox-dist

  echo "Ignoring further changes to often changing config"
  git update-index --assume-unchanged ".config/TheHive/HotShots.conf"
  git update-index --assume-unchanged ".config/transmission/settings.json"
  git update-index --assume-unchanged ".config/Cerebro/config.json"

  echo ""
  echo "====================================="
  echo "Switching to root user to continue..."
  echo "====================================="
  echo "..."
  sudo -s "$dotfiles_dir/$script_name"
  exit
fi


if [ "$(whoami)" == "root" ]; then
  echo ""
  echo "=========================="
  echo "Setting up /etc configs..."
  echo "=========================="

  copy "etc/NetworkManager/dispatcher.d/pia-vpn"
  copy "etc/private-internet-access/pia.conf"
  copy "etc/ssh/ssh_config"
  copy "etc/sysctl.d/10-swappiness.conf"
  copy "etc/sysctl.d/99-idea.conf"
  copy "etc/sysctl.d/99-sysctl.conf"
  copy "etc/systemd/system/getty@tty1.service.d/override.conf"
  copy "etc/systemd/system/paccache.service"
  copy "etc/systemd/system/paccache.timer"
  copy "etc/systemd/system/reflector.service"
  copy "etc/systemd/system/reflector.timer"
  copy "etc/udev/rules.d/81-ac-battery-change.rules"
  copy "etc/X11/xorg.conf.d/30-touchpad.conf"

  echo ""
  echo "================================="
  echo "Enabling and starting services..."
  echo "================================="

  sysctl --system > /dev/null

  systemctl_enable_start "system" "paccache.timer"
  systemctl_enable_start "system" "reflector.timer"
  systemctl_enable_start "system" "NetworkManager.service"
  systemctl_enable_start "system" "NetworkManager-wait-online.service"
  systemctl_enable_start "system" "dropbox@maximbaz.service"
  systemctl_enable_start "system" "docker.service"
  systemctl_enable_start "system" "ufw.service"
  systemctl_enable_start "system" "pcscd.service"

  # tlp
  systemctl_enable_start "system" "tlp.service"
  systemctl_enable_start "system" "tlp-sleep.service"
  systemctl_enable_start "system" "NetworkManager-dispatcher.service"
  systemctl mask "systemd-rfkill.service"

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

  echo "Allowing to use U2F for sudo access"
  sed -zi "s|\(#%PAM-1.0\)\n\(auth    sufficient    pam_u2f.so    cue\n\)\?|\1\nauth    sufficient    pam_u2f.so    cue\n|" /etc/pam.d/sudo

  echo "Disable caching sudo access"
  sed -zi "s|\(## Defaults specification\n[^\n]*\n[^\n]*\n[^\n]*\n\)\(\nDefaults timestamp_timeout=0\n\n\)\?|\1\nDefaults timestamp_timeout=0\n\n|" /etc/sudoers

  echo "Setting limit to journal logs size"
  sed -i "s/#\?\(SystemMaxUse\)=.*/\1=300M/" /etc/systemd/journald.conf

  echo "Enabling various pacman options"
  sed -i "s/#\?\(Color\)/\1/" /etc/pacman.conf
  sed -i "s/#\?\(TotalDownload\)/\1/" /etc/pacman.conf

  echo "Configuring login manager"
  sed -i "s/#\?\(HandleLidSwitch\)=.*/\1=ignore/" /etc/systemd/logind.conf
  sed -i "s/#\?\(HandlePowerKey\)=.*/\1=ignore/" /etc/systemd/logind.conf

  echo "Enabling infinality aliases"
  ln -sf /etc/fonts/conf.avail/30-infinality-aliases.conf /etc/fonts/conf.d/30-infinality-aliases.conf

  echo "Configuring makepkg"
  sed -i "s|#\?\(BUILDDIR\)=.*|\1=/tmp/makepkg|" /etc/makepkg.conf

  echo "Configuring firewall"
  if [[ "$(ufw status | grep -o '[^ ]\+$')" != "active" ]]; then
    ufw default reject
    ufw enable
  fi

  echo "Reload udev rules"
  udevadm control --reload
  udevadm trigger
fi
