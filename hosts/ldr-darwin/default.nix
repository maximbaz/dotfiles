{ inputs, globals, ... }:
inputs.nix-darwin.lib.darwinSystem rec {
  system = "aarch64-darwin";
  specialArgs = {
    firefox-addons = inputs.firefox-addons.packages.${system};
  };
  modules = [
    globals
    # inputs.ldr-private.nixosModules.macos
    inputs.mac-app-util.darwinModules.default
    inputs.home-manager.darwinModules.home-manager
    ../../modules/macos
    {
      nixpkgs.overlays = [
        inputs.firefox-darwin.overlay
        # Add an overlay to override helix-gpt with a specific version of bun
        (final: prev: {
          helix-gpt = prev.helix-gpt.override {
            bun = inputs.nixpkgs-working-bun.legacyPackages.${system}.bun;
          };
        })
      ];

      home-manager.users.${globals.user}.imports = [
        inputs.sops-nix.homeManagerModules.sops
        inputs.nix-index-database.hmModules.nix-index
      ];
    }
  ];
}
