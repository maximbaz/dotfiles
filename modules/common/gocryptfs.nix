{ config, lib, pkgs, ... }: {
  home-manager.users.${config.user} = {
    home.packages = [
      pkgs.gocryptfs
    ];

    systemd.user.tmpfiles.rules = lib.mkIf pkgs.stdenv.isLinux [
      "d /home/${config.user}/decrypted 0700 ${config.user} users -"
    ];
  };
}
