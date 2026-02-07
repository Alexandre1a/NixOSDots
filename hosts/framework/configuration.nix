{ config, pkgs, inputs, ...}:

{
  imports = [
    ./modules.nix
  ];

  networking = {
    hostName = "framework";
    networkmanager = {
      enable = true;
    };
  };

  # Todo -> Display server for all nixos machines (lightdm or smth else)
  
  # User
  users= {
    users = {
      alex = {
        isNormalUser = true;
        description = "Alexandre Delcamp--Enache";
        shell= pkgs.zsh;
        extraGrousp = [ "networkmanager" "wheel" ];
      };
    };
  };
  # HomeManager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "HM-Backup";
    users = {
      "alex" = import ./home.nix;
    };
  };

  programs = {
    hyprland = {
      enable = true;
    };
    zsh = {
      enable = true;
      enableAutosuggestions = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      playerctl
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    pathsToLink = [ "/share/zsh" ];
  };

  system = {
    stateVersion = "24.11";
  };

# End of config
}
