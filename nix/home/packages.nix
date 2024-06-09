{ pkgs, ... }: {
  services.udiskie.enable = true;

  home.packages = with pkgs; [
    android-tools
    android-udev-rules
    asahi-bless
    bfs
    brightnessctl
    calibre
    cargo
    chromium
    dbmate
    delta
    dfrs
    doggo
    dos2unix
    dua
    earlyoom
    editorconfig-core-c
    eza
    fd
    ff2mpv-rust
    ffmpeg
    file
    firefox-wayland
    freerdp
    fzf
    gcc
    git
    glib
    go
    gocryptfs
    goimapnotify
    grim
    helvum
    inotify-tools
    iptables-nftables-compat
    isync
    jq
    kitty
    libnotify
    libreoffice
    meld
    msmtp
    mysql-client
    neomutt
    netcat-openbsd
    nftables
    nix-index
    nodejs
    notmuch
    nzbget
    p7zip
    pam_u2f
    pass
    pavucontrol
    perlPackages.vidir
    pgcli
    pigz
    pinentry-gnome3
    playerctl
    postgresql_16
    progress
    pwgen
    python3
    qalculate-gtk
    qrencode
    qutebrowser
    ripgrep
    rsync
    signal-desktop
    sipcalc
    slurp
    socat
    sqlite
    swappy
    swaybg
    swaylock
    syncthing
    systembus-notify
    tig
    trash-cli
    tree
    udiskie
    unrar
    unzip
    usbguard
    vimiv-qt
    vscode
    w3m
    wireguard-tools
    wl-clipboard
    wldash
    workstyle
    yt-dlp
    zathura
    zip
    zsh

    (pkgs.writeShellScriptBin "audio" (builtins.readFile ../../.local/bin/audio))
    (pkgs.writeShellScriptBin "battery-low-notify" (builtins.readFile ../../.local/bin/battery-low-notify))
    (pkgs.writeShellScriptBin "browser" (builtins.readFile ../../.local/bin/browser))
    (pkgs.writeShellScriptBin "dmenu" (builtins.readFile ../../.local/bin/dmenu))
    (pkgs.writeShellScriptBin "dmenu-wl" (builtins.readFile ../../.local/bin/dmenu))
    (pkgs.writeShellScriptBin "emoji-bootstrap" (builtins.readFile ../../.local/bin/emoji-bootstrap))
    (pkgs.writeShellScriptBin "emoji-dmenu" (builtins.readFile ../../.local/bin/emoji-dmenu))
    (pkgs.writeShellScriptBin "exit-wm" ''
      before_lock() {
          ${lib.getExe pkgs.playerctl} -a pause
          ${lib.getExe' pkgs.bluez "bluetoothctl"} disconnect
          ${lib.getExe pkgs.brightnessctl} set -d kbd_backlight 0
          ${lib.getExe pkgs.sudo} ${lib.getExe' pkgs.systemd "systemctl"} stop pcscd.service
      }

      case "''$1" in
          tty)
              ${lib.getExe' pkgs.systemd "systemctl"} --user stop sway-session.target
              ${lib.getExe' pkgs.sway "swaymsg"} exit
              ;;
          lock)
              before_lock
              ${pkgs.swaylock}/bin/swaylock
              ;;
          suspend)
              before_lock
              ${lib.getExe' pkgs.systemd "systemctl"} -i suspend
              ${pkgs.swaylock}/bin/swaylock
              # ${lib.getExe' pkgs.systemd "systemctl"} --user restart wlsunset
              ;;
          reboot)
              ${lib.getExe' pkgs.systemd "systemctl"} -i reboot
              ;;
          shutdown)
              ${lib.getExe' pkgs.systemd "systemctl"} -i poweroff
              ;;
          *)
              echo "Usage: ''$0 {tty|lock|suspend|reboot|shutdown}"
              exit 2
              ;;
      esac
    '')
    (pkgs.writeShellScriptBin "gnome-terminal" (builtins.readFile ../../.local/bin/gnome-terminal))
    (pkgs.writeShellScriptBin "pass-gen" (builtins.readFile ../../.local/bin/pass-gen))
    (pkgs.writeShellScriptBin "record-area" (builtins.readFile ../../.local/bin/record-area))
    (pkgs.writeShellScriptBin "screenshot-area" (builtins.readFile ../../.local/bin/screenshot-area))
    (pkgs.writeScriptBin "sway-inactive-window-transparency" (builtins.readFile ../../.local/bin/sway-inactive-window-transparency))
    (pkgs.writeShellScriptBin "sway-unfullscreen" (builtins.readFile ../../.local/bin/sway-unfullscreen))
    (pkgs.writeScriptBin "udiskie-dmenu" (builtins.readFile ../../.local/bin/udiskie-dmenu))
  ];
}
