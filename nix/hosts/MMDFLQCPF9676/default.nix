{ inputs, globals, ... }:
inputs.nix-darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  modules = [
    globals
    inputs.maximbaz-private.nixosModules.default
    inputs.mac-app-util.darwinModules.default
    inputs.home-manager.darwinModules.home-manager
    ../../modules/macos
    {
      nixpkgs.overlays = [ inputs.firefox-darwin.overlay ];

      home-manager.users.${globals.user}.imports = [
        inputs.sops-nix.homeManagerModules.sops
        inputs.nix-index-database.hmModules.nix-index
      ];
    }
  ];
}
