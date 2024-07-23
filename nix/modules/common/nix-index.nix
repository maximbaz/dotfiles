{ config, ... }: {
  home-manager.users.${config.user} = {
    programs.nix-index.enable = true;
    programs.nix-index-database.comma.enable = true;
  };
}
