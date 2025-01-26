{ config, pkgs, util, ... }: {
  home-manager.users.${config.user} = {
    systemd.user.services.polkit-gnome-authentication-agent-1 = util.systemdService {
      Description = "polkit-gnome-authentication-agent-1";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    };

    home.packages = [ pkgs.polkit_gnome ];
  };
}
