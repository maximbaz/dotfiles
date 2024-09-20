{ config, ... }: {
  programs.adb.enable = true;
  users.users.${config.user}.extraGroups = [ "adbusers" ];
}
