{ config, ... }: {
  home-manager.users.${config.user}.programs.swayr = {
    enable = true;
    systemd.enable = true;

    settings = {
      focus = {
        lockin_delay = 0;
      };
    };
  };
}
