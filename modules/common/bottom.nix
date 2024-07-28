{ config, ... }: {
  home-manager.users.${config.user}.programs.bottom = {
    enable = true;
    settings = {
      flags = {
        basic = true;
      };
    };
  };
}
