{
  services = {
    logind = {
      lidSwitch = "ignore";
      lidSwitchExternalPower = "ignore";
      powerKey = "lock";
      powerKeyLongPress = "suspend";
    };

    upower.enable = true;
  };
}
