{ config, lib, ... }: {
  nix = {
    optimise.automatic = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      input-fonts.acceptLicense = true;
      joypixels.acceptLicense = true;
    };
  };

  services = { } // lib.attrsets.optionalAttrs (builtins.hasAttr "nix-daemon" config.services) {
    nix-daemon.enable = true;
  };

  imports = [ ../../overlay ];
}
