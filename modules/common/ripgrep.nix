{ config, ... }: {
  home-manager.users.${config.user}.programs.ripgrep = {
    enable = true;
    arguments = [
      "--iglob=!.git"
    ];
  };
}
