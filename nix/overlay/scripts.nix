{ pkgs, ... }:
let
  wrapScript = { name, deps }: pkgs.stdenv.mkDerivation {
    pname = name;
    meta.mainProgram = name;
    version = "1.0.0";
    src = ./bin/${name};
    dontUnpack = true;
    nativeBuildInputs = [ pkgs.makeWrapper ];
    installPhase = "install -Dm755 $src $out/bin/${name}";
    postFixup = "wrapProgram $out/bin/${name} --prefix PATH : /run/current-system/sw/bin/ --prefix PATH : /etc/profiles/per-user/maximbaz/bin/";
  };
in
{
  nixpkgs.overlays = [
    (self: super: {
      audio = wrapScript {
        name = "audio";
        deps = with pkgs; [
          bluez
          wireplumber
        ];
      };

      backup = wrapScript {
        name = "backup";
        deps = with self; [
          coreutils
          dfrs
          dua
          rsync
        ];
      };

      battery-low-notify = wrapScript {
        name = "battery-low-notify";
        deps = with self; [
          acpi
          coreutils
          gnugrep
          libnotify
        ];
      };

      browser = wrapScript {
        name = "browser";
        deps = with self; [
          chromium
          dmenu
          firefox
          gawk
          jq
          mpv
          qutebrowser
          wl-clipboard
        ];
      };

      cggrep = wrapScript {
        name = "cggrep";
        deps = with self; [
          systemd
          ripgrep
        ];
      };

      cgkill = wrapScript {
        name = "cgkill";
        deps = with self; [
          coreutils
          fzf
          gawk
          gnugrep
          systemd
        ];
      };

      cglaunch = wrapScript {
        name = "cglaunch";
        deps = with self; [
          coreutils
          kitty
          systemd
        ];
      };

      cgtoggle = wrapScript {
        name = "cgtoggle";
        deps = with self; [
          cglaunch
          findutils
          gawk
          gnugrep
          systemd
        ];
      };

      dmenu = wrapScript {
        name = "dmenu";
        deps = with self; [
          coreutils
          fzf
          inotify-tools
          kitty
          mktemp
          ncurses
        ];
      };

      emoji-bootstrap = wrapScript {
        name = "emoji-bootstrap";
        deps = with self; [
          coreutils
          git
          jq
          mktemp
          python3
        ];
      };

      emoji-dmenu = wrapScript {
        name = "emoji-dmenu";
        deps = with self; [
          coreutils
          dmenu
          emoji-bootstrap
          gnused
          libnotify
          wl-clipboard
          wl-clipboard-manager
        ];
      };

      exit-wm = wrapScript {
        name = "exit-wm";
        deps = with self; [
          bluez
          brightnessctl
          playerctl
          sudo
          sway
          swaylock
          systemd
        ];
      };

      git-submodule-remove = wrapScript {
        name = "git-submodule-remove";
        deps = with self; [
          git
          zsh
        ];
      };

      neomutt-sendmail = wrapScript {
        name = "neomutt-sendmail";
        deps = with self; [
          msmtp
        ];
      };

      pass-gen = wrapScript {
        name = "pass-gen";
        deps = with self; [
          coreutils
          dmenu
          gnupg
          libnotify
          pwgen
          wl-clipboard
          wl-clipboard-manager
        ];
      };

      record-area = wrapScript {
        name = "record-area";
        deps = with self; [
          coreutils
          ffmpeg
          libnotify
          procps
          slurp
          systemd
          wf-recorder
          wl-clipboard
        ];
      };

      screenshot-area = wrapScript {
        name = "screenshot-area";
        deps = with self; [
          coreutils
          grim
          jq
          slurp
          swappy
          sway
          systemd
          vimiv-qt
        ];
      };

      sway-inactive-window-transparency = wrapScript {
        name = "sway-inactive-window-transparency";
        deps = with self; [
          python3
        ];
      };

      sway-unfullscreen = wrapScript {
        name = "sway-unfullscreen";
        deps = with self; [
          jq
          sway
        ];
      };

      udiskie-dmenu = wrapScript {
        name = "udiskie-dmenu";
        deps = with self; [
          nodejs
        ];
      };

      when = wrapScript {
        name = "when";
        deps = with self; [
          python3
        ];
      };

      wl-clipboard-manager = wrapScript {
        name = "wl-clipboard-manager";
        deps = with self; [
          bat
          coreutils
          dmenu
          file
          findutils
          gawk
          gnused
          kitty
          mktemp
          python3
          sqlite
          wl-clipboard
        ];
      };

      xdg-open = wrapScript {
        name = "xdg-open";
        deps = with self; [
          glib
        ];
      };
    })
  ];
}

