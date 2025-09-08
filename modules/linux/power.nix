{
  services = {
    logind.settings.Login = {
      HandleLidSwitch = "ignore";
      HandleLidSwitchExternalPower = "ignore";
      HandlePowerKey = "lock";
      HandlePowerKeyLongPress = "suspend";
    };

    upower.enable = true;
  };
}
