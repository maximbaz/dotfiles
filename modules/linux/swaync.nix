{ config, ... }: {
  home-manager.users.${config.user}.services.swaync = {
    enable = true;
    settings = {
      image-visibility = "when-available";
      hide-on-clear = true;
      positionY = "bottom";
    };
  };
}
