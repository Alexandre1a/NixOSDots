{ config, pkgs, inputs, ... }:
let
  modules = import ../../modules;
in
{
  # Refer to the nixOS host for info about home-manager
  imports = [
    modules.common.home
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
