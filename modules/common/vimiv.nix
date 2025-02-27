{ config, ... }: {
  home-manager.users.${config.user}.xdg.configFile = {
    "vimiv/vimiv.conf".text = ''
      [GENERAL]
      style = gruvbox
    '';

    "vimiv/styles/gruvbox".text = ''
      [STYLE]
      base00 = #1d2021
      base01 = #3c3836
      base02 = #504945
      base03 = #665c54
      base04 = #bdae93
      base05 = #d5c4a1
      base06 = #ebdbb2
      base07 = #fbf1c7
      base08 = #fb4934
      base09 = #fe8019
      base0a = #fabd2f
      base0b = #b8bb26
      base0c = #8ec07c
      base0d = #83a598
      base0e = #d3869b
      base0f = #d65d0e
    '';
  };
}
