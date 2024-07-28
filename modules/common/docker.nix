{ config, ... }: {
  home-manager.users.${config.user} = { config, ... }: {
    home.sessionVariables.DOCKER_CONFIG = "${config.xdg.configHome}/docker";
  };
}
