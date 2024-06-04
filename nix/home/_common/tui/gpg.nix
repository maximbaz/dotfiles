{ pkgs, config, ... }: {
  programs.gpg = {
    enable = true;
    settings = {
      # TODO work: default-key 256CFDF971216A011DE08CD2C44E48E507AA28B1
      default-key = "04D7A219B0ABE4C2B62A5E654A2B758631E1FD91";
      keyserver = "hkps://keys.openpgp.org";
      keyserver-options = "auto-key-retrieve";
      keyring = "${config.home.homeDirectory}/.dotfiles-private/.gnupg/private.kbx";
    };
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}

