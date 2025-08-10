{ config, ... }: {
  home-manager.users.${config.user}.programs.atuin = {
    enable = true;
    settings = {
      update_check = false;
      style = "compact";
    };
  };
}
