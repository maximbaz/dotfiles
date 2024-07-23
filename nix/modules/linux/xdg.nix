{ config, lib, pkgs, ... }: {
  xdg.portal.wlr = {
    enable = true;
    settings = {
      screencast = {
        chooser_type = "none";
        exec_before = "${lib.getExe' pkgs.swaynotificationcenter "swaync-client"} --dnd-on --skip-wait";
        exec_after = "${lib.getExe' pkgs.swaynotificationcenter "swaync-client"} --dnd-off --skip-wait";
      };
    };
  };

  home-manager.users.${config.user}.xdg = {
    enable = true;

    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = "browser.desktop";
        "x-scheme-handler/https" = "browser.desktop";
        "x-scheme-handler/about" = "browser.desktop";
        "x-scheme-handler/chrome" = "browser.desktop";
        "x-scheme-handler/unknown" = "browser.desktop";
        "x-scheme-handler/mailto" = "neomutt.desktop";
        "application/x-extension-htm" = "browser.desktop";
        "application/x-extension-html" = "browser.desktop";
        "application/x-extension-shtml" = "browser.desktop";
        "application/xhtml+xml" = "browser.desktop";
        "application/xml" = "browser.desktop";
        "application/x-extension-xhtml" = "browser.desktop";
        "application/x-extension-xht" = "browser.desktop";
        "text/html" = "browser.desktop";

        "text/csv" = "helix.desktop";
        "text/plain" = "helix.desktop";
        "text/x-c" = "helix.desktop";
        "text/x-diff" = "helix.desktop";
        "text/x-shellscript" = "helix.desktop";

        "image/gif" = "vimiv.desktop";
        "image/jpeg" = "vimiv.desktop";
        "image/png" = "vimiv.desktop";
        "image/svg+xml" = "vimiv.desktop";
        "image/webp" = "vimiv.desktop";

        "application/vnd.ms-word.document.macroenabled.12" = "writer.desktop";
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";

        "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
      };
    };

    desktopEntries = {
      browser = {
        exec = "${lib.getExe' pkgs.maximbaz-scripts "browser"} %U";
        genericName = "Browser selector";
        name = "browser";
        type = "Application";
        terminal = false;
      };

      helix = {
        exec = "${lib.getExe pkgs.helix} %U";
        genericName = "Helix editor";
        name = "helix";
        type = "Application";
        terminal = true;
      };

      neomutt = {
        categories = [ "Network" "Email" ];
        exec = "${lib.getExe pkgs.neomutt} %u";
        genericName = "Email client";
        mimeType = [ "message/rfc822" "x-scheme-handler/mailto" ];
        name = "neomutt";
        startupNotify = true;
        type = "Application";
        terminal = true;
      };

      signal-desktop = {
        exec = "${lib.getExe' pkgs.signal-desktop-from-src "signal-desktop"}";
        name = "Signal";
        type = "Application";
        terminal = false;
      };
    };
  };
}
