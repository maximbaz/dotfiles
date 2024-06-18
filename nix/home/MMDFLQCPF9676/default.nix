{ config, pkgs, ... }: {
  imports = [
    # ../_common/tui
    ../_common/tui/atuin.nix
    ../_common/tui/bat.nix
    ../_common/tui/bottom.nix
    ../_common/tui/direnv.nix
    ../_common/tui/git.nix
    # ../_common/tui/gpg.nix
    ../_common/tui/helix.nix
    # ../_common/tui/keyboard.nix
    # ../_common/tui/pgcli.nix
    ../_common/tui/ripgrep.nix
    ../_common/tui/tig.nix
    ../_common/tui/w3m.nix
  ];

  home.sessionVariables = {
    DOCKER_CONFIG = "${config.xdg.configHome}/docker";
    CARGO_HOME = "${config.xdg.stateHome}/cargo";
    GOPATH = "${config.xdg.stateHome}/go";
    npm_config_cache = "${config.xdg.cacheHome}/npm";

    LESSHISTFILE = "-";

    PASSWORD_STORE_CHARACTER_SET = "a-zA-Z0-9~!@#$%^&*()-_=+[]{};:,.<>?";
    PASSWORD_STORE_GENERATED_LENGTH = "40";
  };

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    # (python3.withPackages (ps: with ps; [
    #     pyyaml
    #     pynacl
    #     pylint
    #     tldextract
    #     isort
    #     black
    #     pip
    # ]))

    # azure-cli
    bash
    bat
    coreutils
    curl
    diffutils
    gawk
    gh
    gnugrep
    gnum4
    gnumake
    gnused
    gnutar
    gnutls
    # gopls
    # gzip
    kubelogin
    kubernetes-helm
    kubectl
    kubectx
    # less
    # nodePackages.prettier
    # openssh
    # sshpass
    # patch
    # rust-analyzer
    # shellcheck
    #terraform
    # unixtools.watch
    #vault
    # wget
    # wireguard-go
    # which
    # yq
    # zstd


    bfs
    delta
    dfrs
    doggo
    dos2unix
    dua
    editorconfig-core-c
    eza
    fd
    file
    fzf
    gcc
    git
    glib
    go
    jq
    magic-wormhole-rs
    maximbaz-scripts
    pass
    perlPackages.vidir
    pigz
    postgresql_16
    progress
    pwgen
    python3
    qrencode
    rsync
    sipcalc
    socat
    sqlite
    teehee
    tig
    tree
    unrar
    unzip
    vivid
    w3m
    wireguard-tools
    yt-dlp
    zip
    zsh
  ];
}
