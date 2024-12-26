{ inputs, globals, ... }:
inputs.nixpkgs.lib.nixosSystem rec {
  system = "aarch64-linux";
  specialArgs = {
    util = (import ../../util);
    push2talk = inputs.push2talk.defaultPackage.${system};
    network-dmenu = inputs.network-dmenu.defaultPackage.${system};
    firefox-addons = inputs.firefox-addons.packages.${system};
  };
  modules = [
    globals
    inputs.sops-nix.nixosModules.sops
    inputs.apple-silicon-support.nixosModules.apple-silicon-support
    inputs.maximbaz-private.nixosModules.linux
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ../../modules/linux
    {
      personal.enable = true;

      networking.hostName = "home-manitoba";

      hardware.asahi = {
        peripheralFirmwareDirectory = /boot/asahi;
        useExperimentalGPUDriver = true;
        experimentalGPUInstallMode = "replace";
        setupAsahiSound = true;
      };

      boot = {
        loader = {
          efi.canTouchEfiVariables = false;
          systemd-boot = {
            enable = true;
            configurationLimit = 10;
          };
        };
        extraModprobeConfig = ''
          options hid_apple swap_opt_cmd=1 swap_fn_leftctrl=1 iso_layout=1
        '';
        initrd.systemd.enable = true;
      };

      home-manager.users.${globals.user}.imports = [
        inputs.sops-nix.homeManagerModules.sops
        inputs.nix-index-database.hmModules.nix-index
      ];
    }
  ];
}
