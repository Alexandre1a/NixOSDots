{ pkgs, ... }:
{
  imports = [
    ./modules.nix
  ];

  networking = {
    hostName = "laptop";
    networkmanager = {
      enable = true;
    };
  };

  users = {
    users = {
      laptop = {
        isNormalUser = true;
        description = "Laptop";
        shell = pkgs.zsh;
        extraGroups = [ "networkmanager" "wheel" ];
      };
    };
  };

  programs = { 
    hyprland = {
      enable = true;
    };
    zsh = {
      enable = true;
    };
  };

  enviroment = {
    systemPackages = with pkgs; [
      playerctl
      nvtopPackages.nvidia
      libva
      libva-utils
      cudatoolkit

      sddm-astraunot
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    pathToLink = [ "/share/zsh" ];
  };

  system = {
    stateVersion = "24.11";
  };
}
