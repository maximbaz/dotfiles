{ pkgs, ... }: {
  system = {
    keyboard = {
      remapCapsLockToControl = true;
      enableKeyMapping = true;
    };

    defaults = {
      NSGlobalDomain = {
        InitialKeyRepeat = 10;
        KeyRepeat = 1;
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3;
        AppleShowAllFiles = true;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
      };

      menuExtraClock = {
        ShowDayOfWeek = true;
        ShowDate = 2;
        Show24Hour = false;
      };

      universalaccess = {
        reduceMotion = true;
        closeViewScrollWheelToggle = true;
        closeViewZoomFollowsFocus = true;
        mouseDriverCursorSize = 1.5;
      };

      dock = {
        enable-spring-load-actions-on-all-items = true;
        mouse-over-hilite-stack = true;

        mineffect = "genie";
        orientation = "left";
        show-recents = false;
        tilesize = 44;

        persistent-apps = [
          # "${pkgs.firefox-bin}/Applications/Firefox.app"
          "${pkgs.kitty}/Applications/Kitty.app"
          "/Applications/Microsoft Teams (work or school).app"
          "/Applications/Microsoft Outlook.app"
          "/Applications/Microsoft Remote Desktop.app"
        ];
      };

      finder = {
        FXPreferredViewStyle = "clmv";
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        QuitMenuItem = true;
      };

      LaunchServices.LSQuarantine = false;

      CustomUserPreferences = {
        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.dock" = {
          magnification = true;
          largesize = 48;
        };
        "com.apple.finder" = {
          WarnOnEmptyTrash = false;
          FXDefaultSearchScope = "SCcf";
          FXPreferredViewStyle = "clmv";
        };
      };
    };
  };
}

