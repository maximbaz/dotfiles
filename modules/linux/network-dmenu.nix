{ config, network-dmenu, ... }: {
  home-manager.users.${config.user} = {
    home.packages = [ network-dmenu ];
    xdg.configFile."network-dmenu/config.toml".text = ''
      dmenu_cmd = "dmenu"
      dmenu_args = "-f --no-multi"

      [[actions]]
      display = "📡 DNS: Use DHCP server"
      cmd = "sudo resolvectl revert wlan0 && notify-send -i network-wired-no-route 'network-dmenu' 'Using DNS server as set by DHCP'"

      [[actions]]
      display = "📡 DNS: Use 1.1.1.1 server"
      cmd = "sudo resolvectl dns wlan0 '1.1.1.1#cloudflare-dns.com' && sudo resolvectl dnsovertls wlan0 yes && notify-send -i network-wired-no-route 'network-dmenu' 'Using DNS server: 1.1.1.1'"

      [[actions]]
      display = "📡 DNS: Use ControlD server"
      cmd = "sudo resolvectl dns wlan0 '76.76.2.11#x-hagezi-pro.freedns.controld.com' && sudo resolvectl dnsovertls wlan0 yes && notify-send -i network-wired-no-route 'network-dmenu' 'Using DNS server: ControlD'"
    '';
  };
}
