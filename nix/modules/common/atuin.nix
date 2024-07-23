{ config, ... }: {
  home-manager.users.${config.user}.programs.atuin = {
    enable = true;
    settings.sync_address = "https://atuin.vpn.maximbaz.com";
  };
}
