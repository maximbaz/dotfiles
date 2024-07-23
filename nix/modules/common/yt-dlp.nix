{ config, lib, pkgs, ... }: {
  home-manager.users.${config.user} = {
    programs.yt-dlp = {
      enable = true;
      settings = {
        embed-metadata = true;
        sponsorblock-mark = "all";
        downloader = lib.getExe pkgs.aria2;
      };
    };

    home.packages = [ pkgs.aria2 ];
  };
}
