{ lib, pkgs, ... }: {
  imports = [
    ./browserpass.nix
    ./cursor.nix
    ./fonts.nix
    ./mpv.nix
    ./polkit.nix
    ./swaync.nix
    ./sway.nix
    ./waybar.nix
    ./wldash.nix
    ./workstyle.nix
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
}
