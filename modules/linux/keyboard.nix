{ config, ... }: {
  home-manager.users.${config.user}.xdg.configFile."xkb/symbols/us-hyper".text = ''
    default partial alphanumeric_keys modifier_keys

    xkb_symbols "basic" {
        include "us"

        replace key <CAPS> { [ Hyper_L ] };
        replace key <LWIN> { [ Super_L ] };
        modifier_map Mod4 { <META>, Hyper_L };
        modifier_map Mod3 { <META>, Super_L };
    };
  '';
}
