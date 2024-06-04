{ config, pkgs, ... }: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = [{
      height = 25;

      modules-left = [
        "sway/workspaces"
        "sway/mode"
      ];

      modules-right = [
        "custom/progress"
        "custom/usbguard"
        "custom/yubikey"
        "custom/decrypted"
        "custom/systemd"
        "custom/mail"
        "custom/dnd"
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "disk"
        "backlight"
        "sway/language"
        "battery"
        "clock"
      ];

      "custom/progress" = {
        exec = config.xdg.configFile."waybar/bin/progress".target;
        return-type = "json";
        interval = 1;
      };

      "custom/usbguard" = {
        format-icons = {
          icon = "<span foreground='#928374'> </span>";
        };
        format = "{icon}{}";
        exec = config.xdg.configFile."waybar/bin/usbguard".target;
        return-type = "json";
        on-click = "${config.xdg.configFile."waybar/bin/yubikey".target} allow";
        on-click-right = "${config.xdg.configFile."waybar/bin/yubikey".target} reject";
      };

      "custom/yubikey" = {
        exec = config.xdg.configFile."waybar/bin/yubikey".target;
        return-type = "json";
      };

      "custom/decrypted" = {
        exec = config.xdg.configFile."waybar/bin/decrypted".target;
        return-type = "json";
      };

      "custom/systemd" = {
        exec = config.xdg.configFile."waybar/bin/systemd".target;
        return-type = "json";
        interval = 10;
      };

      "custom/mail" = {
        format-icons = {
          icon = "<span foreground='#928374'> </span>";
        };
        format = "{icon}{}";
        exec = config.xdg.configFile."waybar/bin/mail".target;
        return-type = "json";
      };

      "custom/dnd" = {
        tooltip = false;
        format = "{icon}";
        format-icons = {
          notification = "<span foreground='#928374'></span>";
          none = "<span foreground='#928374'></span>";
          dnd-notification = "<span foreground='#928374'></span>";
          dnd-none = "<span foreground='#928374'></span>";
        };
        return-type = "json";
        exec = "${pkgs.swaynotificationcenter}/bin/swaync-client --subscribe-waybar";
        on-click = "${pkgs.swaynotificationcenter}/bin/swaync-client --toggle-dnd --skip-wait";
        escape = true;
      };

      clock = {
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format = "<span foreground='#928374'></span> {:%a, %d %b  <span foreground='#928374'></span> %H:%M}";
      };

      cpu = {
        format = "<span foreground='#928374'></span> {usage}%";
        states = {
          warning = 70;
          critical = 90;
        };
      };

      disk = {
        format = "<span foreground='#928374'></span> {percentage_free}%";
        states = {
          warning = 70;
          critical = 90;
        };
      };

      memory = {
        format = "<span foreground='#928374'></span> {}%";
        states = {
          warning = 70;
          critical = 90;
        };
      };

      backlight = {
        format = "<span foreground='#928374'>{icon}</span> {percent}%";
        format-icons = [ "" ];
      };

      "sway/language" = {
        min-length = 3;
      };

      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "<span foreground='#928374'>{icon}</span> {capacity}%";
        format-charging = "<span foreground='#928374'></span> {capacity}%";
        format-icons = [ "" "" "" "" "" ];
      };

      network = {
        interval = 2;
        format-wifi = "<span foreground='#928374'></span> {essid}";
        format-ethernet = "<span foreground='#928374'></span> {ifname}";
        format-linked = "<span foreground='#928374'></span> {ifname}";
        format-disconnected = " <span foreground='#928374'></span> ";
        tooltip-format = "{ifname}: {ipaddr}/{cidr}\n {bandwidthDownBits}\n {bandwidthUpBits}";
      };

      pulseaudio = {
        format = "<span foreground='#928374'>{icon}</span> {volume}%   {format_source}";
        format-bluetooth = "<span foreground='#928374'>{icon}</span> {volume}%   {format_source}";
        format-bluetooth-muted = "<span foreground='#928374'> {icon}</span>   {format_source}";
        format-muted = "<span foreground='#928374'></span>   {format_source}";
        format-source = "<span foreground='#928374'></span> {volume}%";
        format-source-muted = "<span foreground='#928374'></span>";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" "" ];
        };
        on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        on-click-right = "push2talk -t";
        on-click-middle = "${pkgs.helvum}/bin/helvum";
      };
    }];

    style = ''
      @define-color background #1d2021;
      @define-color foreground #ebdbb2;
      @define-color dim        #928374;
      @define-color yellow     #fabd2f;
      @define-color red        #fb4934;
      @define-color green      #b8bb26;

      * {
        background: @background;
        border: none;
        border-radius: 0;
        font-family: Input, "Font Awesome 6 Free Solid";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: @background;
        color: @foreground;
        transition-property: background-color;
        transition-duration: 0.5s;
      }

      #workspaces button {
        padding: 0 10px;
        background: transparent;
        color: @foreground;
        border-top: 3px solid @background;
        border-bottom: 3px solid transparent;
      }

      #workspaces button.focused {
        border-bottom: 3px solid @green;
      }

      #workspaces button.urgent {
        border-bottom: 3px solid @yellow;
      }

      #mode {
        border-bottom: 3px solid @red;
      }

      #custom-usbguard,
      #custom-decrypted,
      #custom-updates,
      #custom-mail,
      #custom-vpn.off,
      #battery.warning,
      #disk.warning,
      #memory.warning,
      #cpu.warning,
      #custom-dnd.dnd-notification,
      #custom-dnd.dnd-none {
        border-top: 3px solid @background;
        border-bottom: 3px solid @yellow;
      }

      #custom-security,
      #custom-systemd,
      #battery.critical,
      #disk.critical,
      #memory.critical,
      #cpu.critical,
      #custom-yubikey {
        border-top: 3px solid @background;
        border-bottom: 3px solid @red;
      }

      #battery.charging {
        border-top: 3px solid @background;
        border-bottom: 3px solid @green;
      }

      #mode,
      #pulseaudio,
      #custom-usbguard,
      #custom-yubikey,
      #custom-decrypted,
      #custom-security,
      #custom-systemd,
      #custom-updates,
      #custom-mail,
      #network,
      #cpu,
      #disk,
      #memory,
      #backlight,
      #battery,
      #clock {
        padding: 0 6px;
        margin: 0 6px;
      }

      #custom-vpn,
      #custom-dnd,
      #language {
        padding: 0;
        margin: 0 6px;
      }

      #tray {
        margin-left: -1000000px;
      }

      #backlight,
      #battery,
      #clock,
      #cpu,
      #custom-mail,
      #custom-progress,
      #custom-security,
      #custom-systemd,
      #custom-updates,
      #custom-usbguard,
      #custom-yubikey,
      #disk,
      #memory,
      #mode,
      #network,
      #pulseaudio {
        color: @foreground;
      }

      #custom-decrypted,
      #custom-vpn {
        color: @dim;
      }
    '';
  };

  xdg.configFile."waybar/bin/decrypted" = {
    text = ''
      #!/bin/sh

      output() {
          if [ -f "''$HOME/decrypted/.lock" ]; then
              printf '{"text": ""}\n'
          else
              printf '{"text": ""}\n'
          fi
      }

      check() {
          [ ! -d "''$HOME/decrypted" ] && return

          output
          ${pkgs.inotify-tools}/bin/inotifywait -q "''$HOME/decrypted/.lock" > /dev/null 2>&1
          output
          ${pkgs.inotify-tools}/bin/inotifywait -q "''$HOME/decrypted" > /dev/null
          check
      }

      check
    '';
    executable = true;
  };

  xdg.configFile."waybar/bin/dnd" = {
    text = ''
      #!/bin/sh

      on() {
          [ "''$(${pkgs.swaynotificationcenter}/bin/swaync-client --get-dnd)" = "true" ] || ${pkgs.swaynotificationcenter}/bin/swaync-client --toggle-dnd
          pkill -RTMIN+2 -x waybar
      }

      off() {
          [ "''$(${pkgs.swaynotificationcenter}/bin/swaync-client --get-dnd)" = "false" ] || ${pkgs.swaynotificationcenter}/bin/swaync-client --toggle-dnd
          pkill -RTMIN+2 -x waybar
      }

      toggle() {
          ${pkgs.swaynotificationcenter}/bin/swaync-client --toggle-dnd
          pkill -RTMIN+2 -x waybar
      }

      case "''$1" in
          on) on ;;
          off) off ;;
          toggle) toggle ;;
      esac
    '';
    executable = true;
  };

  xdg.configFile."waybar/bin/mail" = {
    text = ''
      #!/bin/sh

      check() {
          [ ! -d "''$HOME/.mail" ] && return

          ${pkgs.notmuch}/bin/notmuch new > /dev/null
          count="''$(${pkgs.notmuch}/bin/notmuch count 'tag:unread')"
          tooltip="There are ''$count new emails"
          if [ "''$count" = "0" ]; then
              printf '{"text": ""}\n'
          else
              printf '{"text": "%s", "tooltip": "%s", "alt": "icon"}\n' "''$count" "''$tooltip"
          fi
          ${pkgs.inotify-tools}/bin/inotifywait -q -e move -e create -e delete "''$HOME/.mail/maximbaz/INBOX/cur" > /dev/null
          check
      }

      check
    '';
    executable = true;
  };

  xdg.configFile."waybar/bin/progress" = {
    text = ''
      #!/bin/sh

      output="$(${pkgs.progress}/bin/progress -q)"
      text="''$(printf "%s" "''$output" | ${pkgs.gnused}/bin/sed 's/\[[^]]*\] //g' | ${pkgs.gawk}/bin/awk 'BEGIN { ORS=" " } NR%3==1 { op=''$1 } NR%3==2 { pct=(''$1+0); if (op != "gpg" && pct > 0 && pct < 100) { print op, ''$1 } }')"
      tooltip="''$(printf "%s" "''$output" | ${pkgs.perl}/bin/perl -pe 's/\n/\\n/g' | ${pkgs.perl}/bin/perl -pe 's/(?:\\n)+''$//')"

      printf '{"text": "%s", "tooltip": "%s"}\n' "''$text" "''$tooltip"
    '';
    executable = true;
  };

  xdg.configFile."waybar/bin/systemd" = {
    text = ''
      #!/bin/sh

      failed_user="''$(${pkgs.systemd}/bin/systemctl --plain --no-legend --user list-units --state=failed | ${pkgs.gawk}/bin/awk '{ print ''$1 }')"
      failed_system="''$(${pkgs.systemd}/bin/systemctl --plain --no-legend list-units --state=failed | ${pkgs.gawk}/bin/awk '{ print ''$1 }')"

      failed_systemd_count="''$(echo -n "''$failed_system" | ${pkgs.gnugrep}/bin/grep -c '^')"
      failed_user_count="''$(echo -n "''$failed_user" | ${pkgs.gnugrep}/bin/grep -c '^')"

      text=''$(( failed_systemd_count + failed_user_count ))

      if [ "''$text" -eq 0 ]; then
          printf '{"text": ""}\n'
      else
          tooltip=""

          [ -n "''$failed_system" ] && tooltip="Failed system services:\n\n''${failed_system}\n\n''${tooltip}"
          [ -n "''$failed_user" ]   && tooltip="Failed user services:\n\n''${failed_user}\n\n''${tooltip}"

          tooltip="''$(printf "''$tooltip" | ${pkgs.perl}/bin/perl -pe 's/\n/\\n/g' | ${pkgs.perl}/bin/perl -pe 's/(?:\\n)+''$//')"

          printf '{"text": " %s", "tooltip": "%s" }\n' "''$text" "''$tooltip"
      fi
    '';
    executable = true;
  };

  xdg.configFile."waybar/bin/usbguard" = {
    text = ''
      #!/bin/sh

      listen() {
          ${pkgs.dbus}/bin/dbus-monitor --system --profile "interface='org.usbguard.Devices1'" |
              while read -r line; do
                  blocked="''$(${pkgs.usbguard}/bin/usbguard list-devices -b | ${pkgs.coreutils}/bin/head -n1 | ${pkgs.gnugrep}/bin/grep -Po 'name "\K[^"]+')"
                  if [ -n "''$blocked" ]; then
                      printf '{"text": "%s"}\n' "''$blocked"
                  else
                      printf '{"text": ""}\n'
                  fi
              done
      }

      allow() {
          blocked_id="''$(${pkgs.usbguard}/bin/usbguard list-devices -b | ${pkgs.coreutils}/bin/head -n1 | ${pkgs.gnugrep}/bin/grep -Po '^[^:]+')"
          ${pkgs.usbguard}/bin/usbguard allow-device "''$blocked_id"
      }

      reject() {
          blocked_id="''$(${pkgs.usbguard}/bin/usbguard list-devices -b | ${pkgs.coreutils}/bin/head -n1 | ${pkgs.gnugrep}/bin/grep -Po '^[^:]+')"
          ${pkgs.usbguard}/bin/usbguard reject-device "''$blocked_id"
      }

      if [ "''$1" = "allow" ]; then
          allow
      elif [ "''$1" = "reject" ]; then
          reject
      else
          listen
      fi
    '';
    executable = true;
  };

  xdg.configFile."waybar/bin/yubikey" = {
    text = ''
      #!/bin/sh

      socket="''${XDG_RUNTIME_DIR:-/run/user/''$UID}/yubikey-touch-detector.socket"

      while true; do
          touch_reasons=()

          if [ ! -e "''$socket" ]; then
              printf '{"text": "Waiting for YubiKey socket"}\n'
              while [ ! -e "''$socket" ]; do ${pkgs.coreutils}/bin/sleep 1; done
          fi
          printf '{"text": ""}\n'

          while read -n5 cmd; do
              reason="''${cmd:0:3}"

              if [ "''${cmd:4:1}" = "1" ]; then
                  touch_reasons+=("''$reason")
              else
                  for i in "''${!touch_reasons[@]}"; do
                      if [ "''${touch_reasons[i]}" = "''$reason" ]; then
                          unset 'touch_reasons[i]'
                          break
                      fi
                  done
              fi

              if [ "''${#touch_reasons[@]}" -eq 0 ]; then
                  printf '{"text": ""}\n'
              else
                  tooltip="YubiKey is waiting for a touch, reasons: ''${touch_reasons[@]}"
                  printf '{"text": "  ", "tooltip": "%s"}\n' "''$tooltip"
              fi
          done < <(${pkgs.netcat-openbsd}/bin/nc -U "''$socket")

          ${pkgs.coreutils}/bin/sleep 1
      done
    '';
    executable = true;
  };
}
