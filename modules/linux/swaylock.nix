{ config, ... }: {
  home-manager.users.${config.user}.programs.swaylock = {
    enable = true;
    settings = {
      color = "111111";
      ignore-empty-password = true;
      indicator-radius = "100";
      indicator-thickness = "10";
      inside-clear-color = "222222";
      inside-color = "1d2021";
      inside-ver-color = "ff99441c";
      inside-wrong-color = "ffffff1c";
      key-hl-color = "ffffff80";
      line-clear-color = "00000000";
      line-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";
      ring-clear-color = "ff994430";
      ring-color = "282828";
      ring-ver-color = "ffffff00";
      ring-wrong-color = "ffffff55";
      separator-color = "22222260";
      text-caps-lock-color = "00000000";
      text-clear-color = "222222";
      text-ver-color = "00000000";
      text-wrong-color = "00000000";
    };
  };
}
