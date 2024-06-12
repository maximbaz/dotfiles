{
  description = "maximbaz";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-silicon-support = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    maximbaz-private.url = "git+file:///home/maximbaz/.dotfiles-private";

    sway-iwt = {
      url = "github:skystar-p/sway-inactive-window-transparency";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, apple-silicon-support, maximbaz-private, sway-iwt, ... }: {
    nixosConfigurations = {
      home-manitoba = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          apple-silicon-support.nixosModules.apple-silicon-support
          ./nix/nixos/home-manitoba
          maximbaz-private.nixosModules.nixos
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              extraSpecialArgs = {
                extras = {
                  sway-inactive-window-transparency = sway-iwt.packages.aarch64-linux.default;
                };
              };
              users.maximbaz.imports = [
                ./nix/home/home-manitoba
                maximbaz-private.nixosModules.home
              ];
            };
          }
        ];
      };
    };
  };
}
