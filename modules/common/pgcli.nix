{ config, ... }: {
  home-manager.users.${config.user} = { config, ... }: {
    xdg.configFile."pgcli/config".text = ''
      [main]
      keyring = False
      table_format = double
      history_file = ${config.xdg.stateHome}/pgcli/history
      use_local_timezone = False
    '';
  };
}
