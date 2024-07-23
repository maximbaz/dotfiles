{ config, pkgs, ... }: {
  home-manager.users.${config.user}.home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };
}
