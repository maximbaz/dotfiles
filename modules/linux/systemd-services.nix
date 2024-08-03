{ config, lib, pkgs, push2talk, ... }:
let
  systemdService = { Description, ExecStart, Environment ? "" }: {
    Unit = {
      Description = Description;
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Environment = Environment;
      ExecStart = ExecStart;
      Restart = "on-failure";
      RestartSec = 10;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
in
{
  home-manager.users.${config.user}.systemd.user.services = {
    battery-low-notify = systemdService {
      Description = "Notify when battery level is low";
      ExecStart = lib.getExe' pkgs.ldr-scripts "battery-low-notify";
    };

    push2talk = systemdService {
      Description = "push2talk";
      Environment = [ "PUSH2TALK_KEYBIND=Super_R" ];
      ExecStart = lib.getExe push2talk;
    };

    sway-inactive-windows-transparency = systemdService {
      Description = "Make inactive windows in sway semi-transparent";
      Environment = [ "INACTIVE_OPACITY=0.7" ];
      ExecStart = lib.getExe pkgs.sway-contrib.inactive-windows-transparency;
    };

    sway-unfullscreen = systemdService {
      Description = "Unfullscreen sway when opening another window";
      ExecStart = lib.getExe' pkgs.ldr-scripts "sway-unfullscreen";
    };

    wl-clipboard-manager = systemdService {
      Description = "Clipboard manager daemon";
      ExecStart = "${lib.getExe' pkgs.ldr-scripts "wl-clipboard-manager"} daemon";
    };

    workstyle = systemdService {
      Description = "Autoname sway workspaces";
      ExecStart = "${lib.getExe pkgs.swayest-workstyle} --deduplicate";
    };
  };
}
