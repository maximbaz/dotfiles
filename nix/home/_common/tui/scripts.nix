{ pkgs, ... }:
let
  scripts = pkgs.symlinkJoin {
    name = "scripts";
    paths = with pkgs; [
      (writeShellScriptBin "backup" (builtins.readFile ./bin/backup))
      (writeShellScriptBin "cggrep" (builtins.readFile ./bin/cggrep))
      (writeShellScriptBin "cgkill" (builtins.readFile ./bin/cgkill))
      (writeShellScriptBin "cglaunch" (builtins.readFile ./bin/cglaunch))
      (writeShellScriptBin "cgtoggle" (builtins.readFile ./bin/cgtoggle))
      (writeShellScriptBin "git-submodule-remove" (builtins.readFile ./bin/git-submodule-remove))
      (writeShellScriptBin "neomutt-sendmail" (builtins.readFile ./bin/neomutt-sendmail))
      (writeScriptBin "when" (builtins.readFile ./bin/when))
      (writeShellScriptBin "xdg-open" (builtins.readFile ./bin/xdg-open))
      coreutils
      dfrs
      dua
      findutils
      fzf
      gawk
      git
      glib
      gnugrep
      kitty
      msmtp
      python3
      rsync
      systemd
      zsh
    ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/backup               --prefix PATH : $out/bin
      wrapProgram $out/bin/cggrep               --prefix PATH : $out/bin
      wrapProgram $out/bin/cgkill               --prefix PATH : $out/bin
      wrapProgram $out/bin/cglaunch             --prefix PATH : $out/bin
      wrapProgram $out/bin/cgtoggle             --prefix PATH : $out/bin
      wrapProgram $out/bin/git-submodule-remove --prefix PATH : $out/bin
      wrapProgram $out/bin/neomutt-sendmail     --prefix PATH : $out/bin
      wrapProgram $out/bin/when                 --prefix PATH : $out/bin
      wrapProgram $out/bin/xdg-open             --prefix PATH : $out/bin
    '';
  };
in
{
  home.packages = [ scripts ];
}
