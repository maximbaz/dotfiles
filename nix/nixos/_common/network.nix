{
  services = {
    resolved.enable = false;
  };

  networking = {
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

  systemd.network = {
    enable = true;
    # wait-online.enable = false;
    networks = {
      "20-wireless" = {
        matchConfig.Name = "wlan0";
        networkConfig.DHCP = "yes";
        dhcpConfig.RouteMetric = 20;
      };
      "50-wired" = {
        matchConfig.Name = "enp*"; # TODO test this
        networkConfig.DHCP = "yes";
        dhcpConfig.RouteMetric = 50;
      };
    };
  };
}
