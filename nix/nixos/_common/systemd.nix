{ pkgs, ... }: {
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
  services.journald.extraConfig = "SystemMaxUse=300M";
  services.dbus.packages = [ pkgs.gcr ];
}
