{ lib, pkgs, ... }: {
  programs.yt-dlp = {
    enable = true;
    settings = {
      embed-metadata = true;
      embed-thumbnail = true;
      sponsorblock-mark = "all";
      downloader = lib.getExe pkgs.aria2;
    };
  };

  home.packages = [ pkgs.aria2 ];
}
