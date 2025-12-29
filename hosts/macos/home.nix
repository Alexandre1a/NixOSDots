{ config, pkgs, inputs, ... }:

{
  # Refer to the nixOS host for info about home-manager
  imports = [
    ../common/home.nix
  ];

  home.stateVersion = "25.11";
  # Allow unfree packages
  #nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Window management (maybe configure it with home-manager)
    yabai
    skhd
    #borders
  ];
}
