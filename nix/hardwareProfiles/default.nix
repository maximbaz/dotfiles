{
  imports = [ ./hardware-configuration.nix ];

  hardware.asahi = {
    peripheralFirmwareDirectory = /boot/asahi;
    useExperimentalGPUDriver = true;
    experimentalGPUInstallMode = "overlay";
  };
}
