{
  description = "ldr";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    firefox-darwin = {
      url = "github:bandithedoge/nixpkgs-firefox-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ldr-private.url = "git+file:///home/ldmsh/private-dotfiles";

    nixpkgs-working-bun = {
      url = "github:nixos/nixpkgs/9e58aca561e18f5197029926db8dbde1738a2ff5";
    };

    push2talk = {
      url = "github:cyrinux/push2talk";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    network-dmenu = {
      url = "github:cyrinux/network-dmenu";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let globals = { user = "ldr"; }; in rec {
      nixosConfigurations = {
        ldr-asahi = import ./hosts/ldr-asahi { inherit inputs globals; };
      };

      darwinConfigurations = {
        ldr-darwin = import ./hosts/ldr-darwin { inherit inputs globals; };
      };

      homeConfigurations = {
        ldr-asahi = nixosConfigurations.ldr-asahi.config.home-manager.users.${globals.user}.home;
        ldr-darwin = darwinConfigurations.ldr-darwin.config.home-manager.users.${globals.user}.home;
      };
    };
}
