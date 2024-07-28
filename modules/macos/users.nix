{ config, ... }: {
  users.users.${config.user}.home = "/Users/${config.user}";
}
