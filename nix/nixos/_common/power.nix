{
  services.logind = {
    lidSwitch = "ignore";
    lidSwitchExternalPower = "ignore";
    powerKey = "lock";
    powerKeyLongPress = "suspend";
  };

  services.upower.enable = true;
}
