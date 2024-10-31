{ config, lib, pkgs, ... }: {
  # environment.sessionVariables.WLR_DRM_NO_MODIFIERS = "1";

  home-manager.users.${config.user} = {
    home.packages = [ pkgs.wluma ];

    xdg.configFile."wluma/config.toml".text = ''
      [als.none]

      [[output.backlight]]
      name = "eDP-1"
      path = "/sys/class/backlight/apple-panel-bl"
      capturer = "wayland"
    '';

    systemd.user.services.wluma = {
      Unit = {
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session-pre.target" ];
      };

      Service = {
        ExecStart = "${lib.getExe pkgs.wluma}";
        Restart = "on-failure";
        EnvironmentFile = "-%E/wluma/service.conf";
        PrivateNetwork = true;
        PrivateMounts = false;
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };
    };
  };
}
