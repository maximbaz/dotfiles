{ config, pkgs, ... }: {
  sops.secrets."nix-serve/private" = { };
  services.nix-serve = {
    enable = true;
    package = pkgs.nix-serve-ng;
    openFirewall = true;
    secretKeyFile = config.sops.secrets."nix-serve/private".path;
    extraParams = "--priority 99";
  };
}
