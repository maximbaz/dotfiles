{
  services.usbguard = {
    enable = true;
    presentControllerPolicy = "apply-policy";
    IPCAllowedGroups = [ "wheel" ];
    dbus.enable = true;
  };
}
