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

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUsersPackages = true;
    backupFileExtension = "HM-Backup";
    users = {
      "laptop" = imports ./home.nix;
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
