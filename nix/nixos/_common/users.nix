{ pkgs, ... }: {
  users.users.maximbaz = {
    password = "CHANGEME";
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
    shell = pkgs.zsh;
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    users.maximbaz = import ../../home;
  };

  services = {
    getty.autologinUser = "maximbaz";
  };
}
