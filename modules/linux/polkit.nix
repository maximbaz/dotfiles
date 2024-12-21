{ config, pkgs, lib, util, ... }: {
  home-manager.users.${config.user} = {
    systemd.user.services.polkit-gnome-authentication-agent-1 = util.systemdService {
      Description = "polkit-gnome-authentication-agent-1";
      ExecStart = lib.getExe' pkgs.polkit_gnome "polkit-gnome-authentication-agent-1";
    };

    home.packages = [ pkgs.polkit_gnome ];
  };
}
