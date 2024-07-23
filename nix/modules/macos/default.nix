{
  system.stateVersion = 4;

  imports = [
    ../common
    ./homebrew.nix
    ./nix.nix
    ./packages.nix
    ./touch-id.nix
    ./users.nix
  ];
}
