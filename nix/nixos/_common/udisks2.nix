{
  services.udisks2.enable = true;

  environment.etc."udisks2/mount_options.conf".text = ''
    [defaults]
    btrfs_defaults=compress=zstd
  '';
}
