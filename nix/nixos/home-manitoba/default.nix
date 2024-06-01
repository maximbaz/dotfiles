{
  imports = [ ./hardware-configuration.nix ../_common ];

  hardware.asahi = {
    peripheralFirmwareDirectory = /boot/asahi;
    useExperimentalGPUDriver = true;
    experimentalGPUInstallMode = "replace";
  };
}
