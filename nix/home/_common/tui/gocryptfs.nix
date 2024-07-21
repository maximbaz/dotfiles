{ config, pkgs, ... }: {
  home.packages = [
    pkgs.gocryptfs
  ];

  systemd.user.tmpfiles.rules = [
    "d ${config.home.homeDirectory}/decrypted 0700 maximbaz users -"
  ];
}
