{ config, ... }: {
  services.udisks2.enable = true;

  environment.etc."udisks2/mount_options.conf".text = ''
    [defaults]
    btrfs_defaults=compress=zstd
  '';

  home-manager.users.${config.user}.services.udiskie.enable = true;
}
