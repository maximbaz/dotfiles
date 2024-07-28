{ config, ... }: {
  home-manager.users.${config.user} = { config, ... }: {
    xdg.configFile."pgcli/config".text = ''
      [main]
      keyring = False
      pager = less -iRFXMx4S
      history_file = ${config.xdg.stateHome}/pgcli/history
    '';
  };
}
