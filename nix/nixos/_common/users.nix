{ pkgs, ... }: {
  users.users.maximbaz = {
    password = "CHANGEME";
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
    shell = pkgs.zsh;
  };

  services = {
    getty.autologinUser = "maximbaz";
  };
}
