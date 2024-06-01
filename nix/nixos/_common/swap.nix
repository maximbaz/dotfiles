{
  swapDevices = [{
    device = "/swap/swapfile";
    size = 4 * 1024;
  }];

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };
}
