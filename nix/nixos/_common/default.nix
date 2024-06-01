{
  imports = [
    ./bluetooth.nix
    ./crypttab.nix
    ./docker.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
    ./pkgs.nix
    ./power.nix
    ./security.nix
    ./ssh.nix
    ./swap.nix
    ./users.nix
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  programs.waybar.enable = true;
  programs.zsh.enable = true;
  programs.adb.enable = true;

  services = {
    #   upower.enable = true;
    #   fstrim.enable = true;
    udisks2.enable = true;
  };

  system.stateVersion = "24.05";
}
