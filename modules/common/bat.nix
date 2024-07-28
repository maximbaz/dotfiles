{ config, ... }: {
  home-manager.users.${config.user}.programs.bat = {
    enable = true;
    config = {
      plain = true;
      theme = "gruvbox-dark";
    };
  };
}
