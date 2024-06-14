{ lib, pkgs, ... }: {
  system.stateVersion = "24.05";

  imports = [
    ../_common
    ./bluetooth.nix
    ./boot.nix
    ./crypttab.nix
    ./docker.nix
    ./earlyoom.nix
    ./fstrim.nix
    ./i18n.nix
    ./network.nix
    ./power.nix
    ./security.nix
    ./sudo.nix
    ./swap.nix
    ./systemd.nix
    ./udisks2.nix
    ./usbguard.nix
    ./users.nix
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  programs.adb.enable = true;
  programs.yubikey-touch-detector.enable = true;

  xdg.portal.wlr = {
    enable = true;
    settings = {
      screencast = {
        chooser_type = "none";
        exec_before = "${lib.getExe' pkgs.swaynotificationcenter "swaync-client"} --dnd-on --skip-wait";
        exec_after = "${lib.getExe' pkgs.swaynotificationcenter "swaync-client"} --dnd-off --skip-wait";
      };
    };
  };
}
