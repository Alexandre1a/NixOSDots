# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules.nix
    ];

  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager = {
      enable = true; # Enables wireless connectivity
    };
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  # Enables SDDM
  services = {
    xserver = {
      enable = true;
    };

    displayManager = {
      defaultSession = "hyprland";
      sddm = {
        enable = true;
        wayland.enable = true;
        #enableHidpi = true;
        package = pkgs.kdePackages.sddm;
        theme = "sddm-astronaut-theme";
        #settings.Theme.CursorTheme = "Bibata-Modern-Classic";
        extraPackages = with pkgs; [
          kdePackages.qtmultimedia
          kdePackages.qtsvg
          kdePackages.qtvirtualkeyboard
        ];
      };
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users = {
      alex = {
        isNormalUser = true;
        description = "Alexandre Delcamp--Enache";
        shell = pkgs.zsh;
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
        ];
      };
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    sharedModules = [
        inputs.sops-nix.homeManagerModules.sops
    ];
    users = {
      "alex" = import ./home.nix;
    };
  };

  # Hyrpland Install
  programs = {
    hyprland = {
      enable = true;
    };
    zsh = { 
      enable = true;
      enableAutosuggestions = true;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.star-citizen
      playerctl
      # Nvidia packages
      nvtopPackages.nvidia
      # Video accel
      libva
      libva-utils
      # Cuda
      cudatoolkit
      # Theme SDDM
      sddm-astronaut
    ];
    # Hint Electron Apps to use Wayland
    sessionVariables.NIXOS_OZONE_WL = "1";
    pathsToLink = [ "/share/zsh" ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
