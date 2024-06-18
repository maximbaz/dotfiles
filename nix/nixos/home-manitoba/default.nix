{
  imports = [
    ./hardware-configuration.nix
    ../_linux
  ];

  networking.hostName = "home-manitoba";

  hardware.asahi = {
    peripheralFirmwareDirectory = /boot/asahi;
    useExperimentalGPUDriver = true;
    experimentalGPUInstallMode = "replace";
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

  # this enables pipewire on Asahi, contrary to the official Nix docs
  sound.enable = true;
}
