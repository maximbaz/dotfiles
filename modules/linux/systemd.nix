{ pkgs, ... }: {
  systemd.settings.Manager.DefaultTimeoutStopSec = 10;
  services.journald.extraConfig = "SystemMaxUse=300M";
  services.dbus.packages = [ pkgs.gcr ];
}
