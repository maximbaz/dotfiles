{
  programs.swayr = {
    enable = true;
    systemd.enable = true;

    settings = {
      focus = {
        lockin_delay = 0;
      };
    };
  };
}
