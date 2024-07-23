{ config, ... }: {
  home-manager.users.${config.user}.programs.browserpass.enable = true;
}
