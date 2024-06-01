{ pkgs, ... }: {
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam = {
      services.sudo.u2fAuth = true;
      services.polkit-1.u2fAuth = true;
      u2f.cue = true;
    };
  };

  services = {
    pcscd.enable = true;
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
