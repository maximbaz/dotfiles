{ pkgs, ... }:
let
  name = "wl-clipboard-manager";
  app = pkgs.symlinkJoin {
    name = name;
    paths = with pkgs; [
      (writeShellScriptBin name (builtins.readFile ./${name}))
      bat
      coreutils
      file
      findutils
      gnused
      mktemp
      sqlite
      wl-clipboard
    ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = "wrapProgram $out/bin/${name} --prefix PATH : $out/bin";
  };
in
{
  systemd.user.services.wl-clipboard-manager = {
    Unit = {
      Description = "Clipboard manager daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${app}/bin/${name} daemon";
      Restart = "on-failure";
      RestartSec = 10;
      TimeoutStopSec = 10;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  home.packages = [
    app
  ];
}
