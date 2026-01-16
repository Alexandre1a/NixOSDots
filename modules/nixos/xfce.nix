{ config, pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      desktopManager = {
        xterm = {
          enable = true;
        };
        xfce {
          enable = true;
        };
      };
    };
    displayManager = {
      defaultSession = "xfce";
    };
  };
}
