{ config, lib, pkgs, util, ... }: {
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

    systemd.user.services.wluma = util.systemdService {
      Description = "wluma";
      ExecStart = "${lib.getExe pkgs.wluma}";
    };
  };
}
