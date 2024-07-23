{
  security = {
    rtkit.enable = true;
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function (action, subject) {
          if (
            (action.id == "org.debian.pcsc-lite.access_pcsc" ||
            action.id == "org.debian.pcsc-lite.access_card") &&
            subject.isInGroup("wheel")
          ) {
            return polkit.Result.YES;
          }
        });
      '';
    };

    pam = {
      services.sudo.u2fAuth = true;
      services.polkit-1.u2fAuth = true;
      u2f.settings.cue = true;
    };
  };

  services.pcscd.enable = true;
}
