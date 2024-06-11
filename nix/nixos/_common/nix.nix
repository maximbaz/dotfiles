{
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      input-fonts.acceptLicense = true;
      joypixels.acceptLicense = true;
    };
  };

  imports = [ ../../overlay ];
}
