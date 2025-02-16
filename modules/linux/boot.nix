{ lib, ... }: {
  systemd.mounts = [{
    what = "tmpfs";
    where = "/tmp";
    type = "tmpfs";
    mountConfig.Options = lib.concatStringsSep "," [
      "mode=1777"
      "strictatime"
      "rw"
      "nosuid"
      "nodev"
      "size=50G"

      # increase inodes, boot.tmp.useTmpfs cannot do this
      "nr_inodes=5000000"
    ];
  }];
}
