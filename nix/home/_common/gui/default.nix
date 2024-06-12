{ lib, pkgs, ... }: {
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

  systemd.user.services.wl-clipboard-manager = {
    Unit = {
      Description = "Clipboard manager daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe' pkgs.maximbaz-scripts "wl-clipboard-manager"} daemon";
      Restart = "on-failure";
      RestartSec = 10;
      TimeoutStopSec = 10;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.services.sway-inactive-windows-transparency = {
    Unit = {
      Description = "Make inactive windows in sway semi-transparent";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      Environment = "INACTIVE_OPACITY=0.7";
      ExecStart = lib.getExe pkgs.sway-contrib.inactive-windows-transparency;
      Restart = "on-failure";
      RestartSec = 10;
      TimeoutStopSec = 10;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
