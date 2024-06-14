{ config, pkgs, ... }: {
  imports = [
    # ../_common/tui
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
    (python3.withPackages (ps: with ps; [
        pyyaml
        pynacl
        pylint
        tldextract
        isort
        black
        pip
    ]))

    azure-cli
    bash
    bat
    coreutils
    curl
    delta
    diffutils
    direnv
    dos2unix
    editorconfig-core-c
    eza
    fd
    findutils
    fzf
    gawk
    gh
    git
    gnugrep
    gnum4
    gnumake
    gnused
    gnutar
    gnutls
    go
    gopls
    gzip
    kubelogin
    kubernetes-helm
    htop
    jq
    kak-lsp
    kakoune
    kubectl
    kubectx
    less
    nodePackages.prettier
    openssh
    sshpass
    pass
    patch
    pgcli
    postgresql
    qrencode
    ripgrep
    rsync
    rust-analyzer
    shellcheck
    sipcalc
    #terraform
    tig
    tree
    unixtools.watch
    unzip
    #vault
    vim
    #webwormhole
    wget
    wireguard-tools
    wireguard-go
    which
    xplr
    yq
    zsh
    zstd
    mtr
  ];
}
