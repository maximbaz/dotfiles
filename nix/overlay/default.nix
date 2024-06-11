{
  nixpkgs.overlays = [
    (import ./overrides.nix)
  ];

  imports = [ ./scripts.nix ];
}
