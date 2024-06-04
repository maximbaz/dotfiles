{ pkgs, ... }: {
  services.udiskie.enable = true;

  home.packages = with pkgs; [
    android-tools
    android-udev-rules
    asahi-bless
    bfs
    biome
    brightnessctl
    calibre
    cargo
    chromium
    clang-tools
    dbmate
    delta
    dfrs
    docker-compose-language-service
    dockerfile-language-server-nodejs
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
    git
    glib
    go
    gocryptfs
    goimapnotify
    golangci-lint
    golangci-lint-langserver
    gopls
    gotools
    grim
    helix
    helix-gpt
    helvum
    inotify-tools
    iptables-nftables-compat
    isync
    jq
    (kakoune.override { plugins = with kakounePlugins; [ kakoune-lsp ]; })
    kitty
    libnotify
    libreoffice
    marksman
    meld
    mpv
    mpvScripts.mpris
    mpvScripts.uosc
    msmtp
    mysql-client
    neomutt
    netcat-openbsd
    nftables
    nil
    nix-index
    nixpkgs-fmt
    nodejs
    nodePackages.bash-language-server
    nodePackages.prettier
    nodePackages.typescript-language-server
    notmuch
    nzbget
    p7zip
    pam_u2f
    pass
    pavucontrol
    pgcli
    pgformatter
    pigz
    pinentry-gnome3
    playerctl
    polkit_gnome
    postgresql_16
    progress
    pwgen
    (python3.withPackages (p: (with p; [
      black
      isort
      python-lsp-black
      python-lsp-server
    ])))
    qalculate-gtk
    qrencode
    qutebrowser
    ripgrep
    rsync
    rust-analyzer
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
    taplo
    taplo-lsp
    terraform-ls
    tig
    trash-cli
    tree
    udiskie
    unrar
    unzip
    usbguard
    vimiv-qt
    vscode
    vscode-langservers-extracted
    w3m
    wireguard-tools
    wl-clipboard
    wldash
    workstyle
    yaml-language-server
    yt-dlp
    zathura
    zip
    zsh

    (pkgs.writeShellScriptBin "cglaunch" (builtins.readFile ../../.local/bin/cglaunch))
    (pkgs.writeShellScriptBin "audio" (builtins.readFile ../../.local/bin/audio))
    (pkgs.writeShellScriptBin "backup" (builtins.readFile ../../.local/bin/backup))
    (pkgs.writeShellScriptBin "backup-packages" (builtins.readFile ../../.local/bin/backup-packages))
    (pkgs.writeShellScriptBin "battery-low-notify" (builtins.readFile ../../.local/bin/battery-low-notify))
    (pkgs.writeShellScriptBin "browser" (builtins.readFile ../../.local/bin/browser))
    (pkgs.writeShellScriptBin "bulkrename" (builtins.readFile ../../.local/bin/bulkrename))
    (pkgs.writeShellScriptBin "cggrep" (builtins.readFile ../../.local/bin/cggrep))
    (pkgs.writeShellScriptBin "cgkill" (builtins.readFile ../../.local/bin/cgkill))
    (pkgs.writeShellScriptBin "cglaunch" (builtins.readFile ../../.local/bin/cglaunch))
    (pkgs.writeShellScriptBin "cgtoggle" (builtins.readFile ../../.local/bin/cgtoggle))
    (pkgs.writeShellScriptBin "checkmail" (builtins.readFile ../../.local/bin/checkmail))
    (pkgs.writeShellScriptBin "dmenu" (builtins.readFile ../../.local/bin/dmenu))
    (pkgs.writeShellScriptBin "dmenu-wl" (builtins.readFile ../../.local/bin/dmenu))
    (pkgs.writeShellScriptBin "emoji-bootstrap" (builtins.readFile ../../.local/bin/emoji-bootstrap))
    (pkgs.writeShellScriptBin "emoji-dmenu" (builtins.readFile ../../.local/bin/emoji-dmenu))
    (pkgs.writeShellScriptBin "exit-wm" (builtins.readFile ../../.local/bin/exit-wm))
    (pkgs.writeShellScriptBin "git-submodule-remove" (builtins.readFile ../../.local/bin/git-submodule-remove))
    (pkgs.writeShellScriptBin "gitui" (builtins.readFile ../../.local/bin/gitui))
    (pkgs.writeShellScriptBin "gnome-terminal" (builtins.readFile ../../.local/bin/gnome-terminal))
    (pkgs.writeShellScriptBin "kak-man-pager" (builtins.readFile ../../.local/bin/kak-man-pager))
    (pkgs.writeShellScriptBin "mockbuild" (builtins.readFile ../../.local/bin/mockbuild))
    (pkgs.writeShellScriptBin "neomutt-sendmail" (builtins.readFile ../../.local/bin/neomutt-sendmail))
    (pkgs.writeShellScriptBin "pass-gen" (builtins.readFile ../../.local/bin/pass-gen))
    (pkgs.writeShellScriptBin "record-area" (builtins.readFile ../../.local/bin/record-area))
    (pkgs.writeShellScriptBin "screenshot-area" (builtins.readFile ../../.local/bin/screenshot-area))
    (pkgs.writeScriptBin "sway-inactive-window-transparency" (builtins.readFile ../../.local/bin/sway-inactive-window-transparency))
    (pkgs.writeShellScriptBin "sway-unfullscreen" (builtins.readFile ../../.local/bin/sway-unfullscreen))
    (pkgs.writeScriptBin "udiskie-dmenu" (builtins.readFile ../../.local/bin/udiskie-dmenu))
    (pkgs.writeScriptBin "when" (builtins.readFile ../../.local/bin/when))
    (pkgs.writeShellScriptBin "wl-clipboard-manager" (builtins.readFile ../../.local/bin/wl-clipboard-manager))
    (pkgs.writeShellScriptBin "xdg-open" (builtins.readFile ../../.local/bin/xdg-open))
  ];
}
