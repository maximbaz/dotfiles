{ config, ... }: {
  imports = [
    ../_common/gui
    ../_common/tui
    ../packages.nix
  ];

  home.sessionVariables = {
    DIFFPROG = "meld";

    # MOZ_GMP_PATH = "/var/lib/widevine/gmp-widevinecdm/system-installed:/usr/lib64/mozilla/plugins/gmp-gmpopenh264/system-installed";

    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland-egl";
    QT_STYLE_OVERRIDE = "Adwaita-dark";

    DOCKER_CONFIG = "${config.xdg.configHome}/docker";
    CARGO_HOME = "${config.xdg.stateHome}/cargo";
    GOPATH = "${config.xdg.stateHome}/go";
    npm_config_cache = "${config.xdg.cacheHome}/npm";

    LESSHISTFILE = "-";

    PASSWORD_STORE_CHARACTER_SET = "a-zA-Z0-9~!@#$%^&*()-_=+[]{};:,.<>?";
    PASSWORD_STORE_GENERATED_LENGTH = "40";
  };

  home.stateVersion = "24.05";
}
