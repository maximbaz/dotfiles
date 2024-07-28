{ config, ... }: {
  home-manager.users.${config.user}.gtk = {
    enable = true;
    gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };
    gtk4.extraConfig = { gtk-application-prefer-dark-theme = true; };
  };
}
