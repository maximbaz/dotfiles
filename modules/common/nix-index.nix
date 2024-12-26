{ config, nix-index-with-small-db, ... }: {
  home-manager.users.${config.user} = {
    programs.nix-index.enable = true;
    programs.nix-index-database.comma.enable = true;
    programs.nix-index.package = nix-index-with-small-db;
  };
}
