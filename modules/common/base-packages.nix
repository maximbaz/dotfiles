{ lib, pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      curl
      git
      git-lfs
      helix
      marksman
      wget
      devenv
      rustup
    ];

    variables = {
      EDITOR = lib.getExe pkgs.helix;
      VISUAL = lib.getExe pkgs.helix;
    };
  };
}
