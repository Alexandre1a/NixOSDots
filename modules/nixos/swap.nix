{
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024;  # 8 GB Swap
  }];
  zramSwap = {
    enable = true;
    memoryMax = 16 * 1024 * 1024 * 1024;  # 16 GB ZRAM
  };
}
