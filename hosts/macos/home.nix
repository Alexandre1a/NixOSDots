{ config, pkgs, inputs, ... }:

{
  # Refer to the nixOS host for info about home-manager
  imports = [
    ../common/home.nix
  ];

  
  home = {
    packages = with pkgs; [
      # Window management (maybe configure it with home-manager)
      yabai
      skhd
      #borders
    ];
    stateVersion = "25.11";
  };
}
