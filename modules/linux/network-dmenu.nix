{ config, network-dmenu, ... }: {
  home-manager.users.${config.user} = {
    home.packages = [ network-dmenu ];
    xdg.configFile."network-dmenu/config.toml".text = ''
      dmenu_cmd = "dmenu"
      dmenu_args = "-f --no-multi"
    '';
  };
}
