{ config, pkgs, lib, ... }: {
  home-manager.users.${config.user} = {
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      Unit = {
        Description = "polkit-gnome-authentication-agent-1";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = lib.getExe' pkgs.polkit_gnome "polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 10;
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

    home.packages = [ pkgs.polkit_gnome ];
  };
}
