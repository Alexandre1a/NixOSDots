{
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 24 * 1024;  # 24 GB Swap
  }];
  zramSwap = {
    enable = true;
    memoryMax = 16 * 1024 * 1024 * 1024;  # 16 GB ZRAM
  };
}
