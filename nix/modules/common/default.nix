{ config, lib, ... }: {
  imports = [
    ./atuin.nix
    ./base-packages.nix
    ./bat.nix
    ./bottom.nix
    ./browserpass.nix
    ./direnv.nix
    ./docker.nix
    ./firefox.nix
    ./fonts.nix
    ./git.nix
    ./gocryptfs.nix
    ./gpg.nix
    ./gtk.nix
    ./helix.nix
    ./kitty.nix
    ./mpv.nix
    ./nix-index.nix
    ./nix.nix
    ./pgcli.nix
    ./ripgrep.nix
    ./swappy.nix
    ./syncthing.nix
    ./tailscale.nix
    ./tig.nix
    ./timezone.nix
    ./vimiv.nix
    ./w3m.nix
    ./yt-dlp.nix
    ./zsh.nix
  ];

  config.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${config.user}.home.stateVersion = "24.05";
  };

  options = {
    user = lib.mkOption {
      type = lib.types.str;
      description = "Primary user of the system";
    };

    personal.enable = lib.mkEnableOption "Personal setup";
  };

  # # TODO
  # config.home-manager.users.${config.user}.home.sessionVariables = {
  #   # QT_QPA_PLATFORM = "wayland-egl";
  #   # QT_STYLE_OVERRIDE = "Adwaita-dark";

  #   # CARGO_HOME = "${config.xdg.stateHome}/cargo";
  #   # GOPATH = "${config.xdg.stateHome}/go";
  #   # npm_config_cache = "${config.xdg.cacheHome}/npm";
  #   # LESSHISTFILE = "-";
  # };
}
