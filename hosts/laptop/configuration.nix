{ config, inputs, pkgs, ... }:

{
  imports = [
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

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "HM-Backup";
    users = {
      "laptop" = import ./home.nix;
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

  environment = {
    systemPackages = with pkgs; [
      playerctl
      nvtopPackages.nvidia
      libva
      libva-utils
      cudatoolkit

      sddm-astronaut
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    pathsToLink = [ "/share/zsh" ];
  };

  system = {
    stateVersion = "24.11";
  };
}
