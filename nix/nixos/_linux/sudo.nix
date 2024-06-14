{ pkgs, lib, ... }: {
  security.sudo = {
    enable = true;

    extraConfig = ''
      Defaults timestamp_timeout=0
      Defaults passwd_timeout=0
    '';

    extraRules = [{
      groups = [ "wheel" ];
      commands = [
        { command = "${lib.getExe' pkgs.systemd "systemctl"} stop pcscd.service"; options = [ "SETENV" "NOPASSWD" ]; }
      ];
    }];
  };
}
