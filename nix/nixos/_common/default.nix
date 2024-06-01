{ pkgs, ... }: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
    extraModprobeConfig = ''
      options hid_apple swap_opt_cmd=1 swap_fn_leftctrl=1 iso_layout=1
    '';
    initrd.systemd.enable = true;
  };

  sound.enable = true;

  time.timeZone = "Europe/Copenhagen";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "en_DK.UTF-8/UTF-8"
    ];
  };

  networking = {
    hostName = "home-manitoba";
    useDHCP = false;
    wireless.iwd = {
      enable = true;
      settings.General.EnableNetworkConfiguration = true;
    };
    nftables.enable = true;
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [
        22000 # syncthing
      ];
      allowedUDPPorts = [
        22000 # syncthing
        21027 # syncthing discovery
      ];
    };
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      input-fonts.acceptLicense = true;
    };
    overlays = [ (import ../../overlay) ];
  };

  users.users.maximbaz = {
    password = "CHANGEME";
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
    shell = pkgs.zsh;
  };

  environment = {
    systemPackages = with pkgs; [
      git
      helix
      curl
      wget
    ];

    etc.crypttab.text = ''
      backup_sandisk  LABEL=backup_sandisk    none    noauto,fido2-device=auto
      backup_wd       LABEL=backup_wd         none    noauto,fido2-device=auto
    '';

    sessionVariables.NIXOS_OZONE_WL = "1";

    variables.EDITOR = "hx";
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  programs.waybar.enable = true;
  programs.zsh.enable = true;
  programs.adb.enable = true;

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
    #   upower.enable = true;
    #   fstrim.enable = true;
    udisks2.enable = true;
    getty.autologinUser = "maximbaz";
    pcscd.enable = true;
    resolved.enable = false;

    logind = {
      lidSwitch = "ignore";
      lidSwitchExternalPower = "ignore";
      powerKey = "lock";
      powerKeyLongPress = "suspend";
    };
  };

  swapDevices = [{
    device = "/swap/swapfile";
    size = 4 * 1024;
  }];


  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  systemd = {
    network = {
      enable = true;
      # wait-online.enable = false;
      networks = {
        "20-wireless" = {
          matchConfig.Name = "wlan0";
          networkConfig.DHCP = "yes";
          dhcpConfig.RouteMetric = 20;
        };
        "50-wired" = {
          matchConfig.Name = "enp*";
          networkConfig.DHCP = "yes";
          dhcpConfig.RouteMetric = 50;
        };
      };
    };

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

  # xdg = {
  #   portal = {
  #     enable = true;
  #     extraPortals = with pkgs; [
  #       xdg-desktop-portal-gtk
  #       xdg-desktop-portal-wlr
  #     ];
  #   };


  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    users.maximbaz = import ../../home;
  };

  system.stateVersion = "24.05";
}
