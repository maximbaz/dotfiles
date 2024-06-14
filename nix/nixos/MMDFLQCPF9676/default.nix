{
  programs.zsh.enable = true;

  services.nix-daemon.enable = true;
  nix.settings = {
    "extra-experimental-features" = [ "nix-command" "flakes" ];
  };

  users.users.maximbaz.home = "/Users/maximbaz";

  system.stateVersion = 4;
}
