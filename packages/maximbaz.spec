%global pkgver 1.4.0

Name:       maximbaz
Version:    %pkgver
Release:    %autorelease
Summary:    Packages installed by maximbaz
License:    ISC
BuildArch:  noarch

Recommends: gawk
Recommends: moreutils

%description
%{summary}.

%posttrans
dnf -y install dnf-plugins-core
dnf -y config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
dnf -y copr enable atim/kakoune
dnf -y copr enable cyrinux/misc
dnf -y copr enable hyperreal/better_fonts
dnf -y copr enable erikreider/SwayNotificationCenter
dnf -y copr enable lead2gold/nzbget
dnf -y copr enable maximbaz/browserpass
dnf -y copr enable maximbaz/personal
dnf -y copr enable nucleo/gocryptfs
dnf -y copr enable solopasha/hyprland
dnf -y copr enable useidel/signal-desktop

for f in /etc/yum.repos.d/_copr*; do
    awk '!/^priority=/ {print} /^priority=/ {print "priority=100"; found=1} END {if (!found) print "priority=100"}' "$f" | sponge "$f"
done

%package    base
Version:    %pkgver
Release:    %autorelease
Summary:    Packages installed by maximbaz
License:    ISC
BuildArch:  noarch

Recommends: abattis-cantarell-fonts
Recommends: adwaita-qt5
Recommends: adwaita-qt6
Recommends: android-tools
Recommends: apanov-heuristica-fonts
Recommends: aspell-da
Recommends: aspell-en
Recommends: aspell-ru
Recommends: bat
Recommends: bfs
Recommends: binwalk
Recommends: browserpass
Recommends: browserpass-chromium
Recommends: browserpass-firefox
Recommends: calibre
Recommends: cargo
Recommends: chromium
Recommends: clang
Recommends: community-mysql
Recommends: copr-cli
Recommends: courier-prime-fonts
Recommends: dbmate
Recommends: dejavu-fonts-all
Recommends: dfrs
Recommends: direnv
Recommends: docker-ce
Recommends: doggo
Recommends: dos2unix
Recommends: dua-cli
Recommends: earlyoom
Recommends: editorconfig
Recommends: eza
Recommends: fd-find
Recommends: ff2mpv
Recommends: ffmpeg-free
Recommends: firefox
Recommends: fontawesome-fonts-all
Recommends: freerdp
Recommends: fzf
Recommends: gcr3
Recommends: gdisk
Recommends: gh
Recommends: git
Recommends: git-delta
Recommends: gnome-keyring
Recommends: gocryptfs
Recommends: goimapnotify
Recommends: golang
Recommends: golang-x-tools-gopls
Recommends: google-droid-fonts-all
Recommends: google-noto-sans-cjk-fonts
Recommends: google-noto-sans-fonts
Recommends: google-noto-serif-cjk-fonts
Recommends: google-noto-serif-fonts
Recommends: helix
Recommends: helvum
Recommends: htop
Recommends: hyprland
Recommends: hyprland-autoname-workspaces
Recommends: ImageMagick
Recommends: inkscape
Recommends: inotify-tools
Recommends: iptables-nft
Recommends: isync
Recommends: iwd
Recommends: jq
Recommends: kak-lsp
Recommends: kakoune
Recommends: kitty
Recommends: krita
Recommends: kubernetes-client
Recommends: lato-fonts
Recommends: lbzip2
Recommends: liberation-fonts
Recommends: libgnome-keyring
Recommends: libreoffice
Recommends: light
Recommends: maximbaz
Recommends: meld
Recommends: meson
Recommends: mock
Recommends: mpv
Recommends: mpv-mpris
Recommends: msmtp
Recommends: neomutt
Recommends: nextcloud-client
Recommends: nftables
Recommends: nmap-ncat
Recommends: nodejs
Recommends: nodejs-bash-language-server
Recommends: notmuch
Recommends: nzbget
Recommends: open-sans-fonts
Recommends: p7zip
Recommends: pam-u2f
Recommends: pamu2fcfg
Recommends: pass
Recommends: passmenu
Recommends: pavucontrol
Recommends: pgcli
Recommends: pigz
Recommends: pinentry-gnome3
Recommends: playerctl
Recommends: polkit-gnome
Recommends: postgresql
Recommends: progress
Recommends: pulseaudio-utils
Recommends: push2talk
Recommends: pwgen
Recommends: pylint
Recommends: python-unversioned-command
Recommends: python3-lsp-server+all
Recommends: python3-pip
Recommends: qalculate-gtk
Recommends: qrencode
Recommends: qutebrowser
Recommends: ripgrep
Recommends: rpmconf
Recommends: rpmdevtools
Recommends: rpmlint
Recommends: rsync
Recommends: rust-analyzer
Recommends: setroubleshoot
Recommends: shfmt
Recommends: signal-desktop
Recommends: sipcalc
Recommends: socat
Recommends: sqlite
Recommends: strace
Recommends: swappy
Recommends: swaybg
Recommends: swaylock
Recommends: SwayNotificationCenter
Recommends: syncthing
Recommends: systembus-notify
Recommends: systemd-oomd-defaults
Recommends: teehee
Recommends: terminus-fonts-console
Recommends: tig
Recommends: tlp
Recommends: trash-cli
Recommends: typetogether-literata-fonts
Recommends: udiskie
Recommends: unrar
Recommends: unzip
Recommends: usbguard
Recommends: usbguard-dbus
Recommends: vimiv-qt
Recommends: w3m
Recommends: waybar
Recommends: wireguard-tools
Recommends: wl-clipboard
Recommends: wldash
Recommends: yarnpkg
Recommends: yq
Recommends: yt-dlp
Recommends: yubikey-touch-detector
Recommends: zathura-pdf-mupdf
Recommends: zip
Recommends: zsh

%description base
%{summary}.

%package    asahi
Version:    %pkgver
Release:    %autorelease
Summary:    Required Asahi packages
License:    ISC
BuildArch:  noarch

Recommends: asahi-platform-metapackage
Recommends: asahi-repos
Recommends: fedora-asahi-remix-scripts
Recommends: grub2-efi-aa64
Recommends: grub2-efi-aa64-modules
Recommends: shim-aa64

%description asahi
%{summary}.

%prep

%build

%install

%files

%files base

%files asahi

%changelog
%autochangelog
