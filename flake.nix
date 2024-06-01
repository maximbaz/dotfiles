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
  };

  outputs = { nixpkgs, home-manager, apple-silicon-support, maximbaz-private, ... }: {
    nixosConfigurations = {
      home-manitoba =
        let system = "aarch64-linux";
        in nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            apple-silicon-support.nixosModules.apple-silicon-support
            home-manager.nixosModules.home-manager
            maximbaz-private.nixosModules.default
            ./nix/nixos/home-manitoba
          ];
        };
    };
  };
}
