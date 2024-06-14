{
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam = {
      services.sudo.u2fAuth = true;
      services.polkit-1.u2fAuth = true;
      u2f.cue = true;
    };
  };

  services.pcscd.enable = true;
}
