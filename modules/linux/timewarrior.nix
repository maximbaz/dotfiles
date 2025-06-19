{ config, pkgs, ... }: {
  home-manager.users.${config.user} = {
    home.packages = [ pkgs.timewarrior ];

    xdg.configFile."timewarrior/timewarrior.cfg".text = ''
      define theme:
        description = "gruvbox"
        colors:
          exclusion = "color on color8"
          today = "color208"
          holiday = "color13"
          label = "color243"
          ids = "color4"
          debug = "color14"
        palette:
          color01 = "color15 on color1"
          color02 = "color15 on color2"
          color03 = "color15 on color3"
          color04 = "color15 on color4"
          color05 = "color15 on color5"
          color06 = "color15 on color6"
          color07 = "color0 on color7"
          color08 = "color0 on color8"
          color09 = "color0 on color9"
          color10 = "color0 on color10"
          color11 = "color0 on color11"
          color12 = "color0 on color12"
          color13 = "color0 on color13"
          color14 = "color0 on color14"
          color15 = "color0 on color15"
    '';
  };
}

