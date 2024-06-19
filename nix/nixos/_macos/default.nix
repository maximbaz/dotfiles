{
  system.stateVersion = 4;

  imports = [
    ../_common
    ./nix.nix
    ./touch-id.nix
    ./users.nix
  ];
}
