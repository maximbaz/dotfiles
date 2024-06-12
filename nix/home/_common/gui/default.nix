{ lib, pkgs, ... }:
let
  systemdService = { Description, ExecStart, Environment ? "" }: {
    Unit = {
      Description = Description;
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Environment = Environment;
      ExecStart = ExecStart;
      Restart = "on-failure";
      RestartSec = 10;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
in
{
  imports = [
    ./browserpass.nix
    ./cursor.nix
    ./fonts.nix
    ./gtk.nix
    ./mpv.nix
    ./polkit.nix
    ./swaync.nix
    ./sway.nix
    ./swaylock.nix
    ./waybar.nix
    ./wldash.nix
    ./workstyle.nix
    ./xdg.nix
  ];

  systemd.user.services = {
    battery-low-notify = systemdService {
      Description = "Notify when battery level is low";
      ExecStart = lib.getExe' pkgs.maximbaz-scripts "battery-low-notify";
    };

    sway-inactive-windows-transparency = systemdService {
      Description = "Make inactive windows in sway semi-transparent";
      Environment = "INACTIVE_OPACITY=0.7";
      ExecStart = lib.getExe pkgs.sway-contrib.inactive-windows-transparency;
    };

    sway-unfullscreen = systemdService {
      Description = "Unfullscreen sway when opening another window";
      ExecStart = lib.getExe' pkgs.maximbaz-scripts "sway-unfullscreen";
    };

    swayr = systemdService {
      Description = "swayr daemon";
      ExecStart = lib.getExe' pkgs.swayr "swayrd";
    };

    wl-clipboard-manager = systemdService {
      Description = "Clipboard manager daemon";
      ExecStart = "${lib.getExe' pkgs.maximbaz-scripts "wl-clipboard-manager"} daemon";
    };
  };
}
