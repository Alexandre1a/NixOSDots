{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules.nix
  ];

  # Bootloader
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };

  # Networking
  networking = {
    hostname = "light";
    networkmanager = {
      enable = true;
    };
  };

  # Services
  services = {
    # Desktop Environment/Greeter
    xserver = {
      enable = true;
      displayManager = {
        defaultSession = "xfce";
        lightdm = {
          enable = true;
        };
      };
      desktopManager = {
        xfce = {
          enable = true;
        };
        xterm = {
          enable = true;
        };
      };
    };
  };

  # General nix settings
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  # Nixpkgs config
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  system = {
    stateVersion = "24.11";
  };
}
