{ config, ... }: {
  users.users.${config.user}.extraGroups = [ "dialout" ];
}
