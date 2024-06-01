{ pkgs, ... }: {
  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    package = pkgs.sway;
    systemd.enable = true;
  };
} 
