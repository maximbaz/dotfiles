{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      curl
      git
      helix
      wget
    ];

    variables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };
  };
}
