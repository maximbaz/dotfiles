{ config, lib, pkgs, unstable, ... }: {
  home-manager.users.${config.user} = {
    programs.yt-dlp = {
      enable = true;
      package = unstable.yt-dlp;
      settings = {
        embed-metadata = true;
        sponsorblock-mark = "all";
        downloader = lib.getExe pkgs.aria2;
      };
    };

    home.packages = [ pkgs.aria2 ];
  };
}
