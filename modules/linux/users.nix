{ config, pkgs, ... }: {
  users.users.${config.user} = {
    password = "CHANGEME";
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "input" ];
    shell = pkgs.zsh;
  };

  services.getty.autologinUser = "${config.user}";
}
