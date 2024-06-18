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

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    maximbaz-private.url = "git+file:///home/maximbaz/.dotfiles-private";

    push2talk = {
      url = "github:cyrinux/push2talk";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, apple-silicon-support, nix-darwin, maximbaz-private, push2talk, nix-index-database, ... }: {
    nixosConfigurations = {
      home-manitoba = let system = "aarch64-linux"; in nixpkgs.lib.nixosSystem {
        inherit system;
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
                push2talk = push2talk.defaultPackage.${system};
              };
              users.maximbaz.imports = [
                nix-index-database.hmModules.nix-index
                ./nix/home/home-manitoba
                maximbaz-private.nixosModules.home
              ];
            };
          }
        ];
      };
    };

    darwinConfigurations = {
      MMDFLQCPF9676 = let system = "aarch64-darwin"; in nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ./nix/nixos/MMDFLQCPF9676
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              users.maximbaz.imports = [
                nix-index-database.hmModules.nix-index
                ./nix/home/MMDFLQCPF9676
              ];
            };
          }
        ];
      };
    };
  };
}
