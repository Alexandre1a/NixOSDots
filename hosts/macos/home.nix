{ config, pkgs, inputs, ... }:

let
  commonHome = import ../common/home.nix {
    inherit config pkgs inputs;
    username = "alex";
    homeDir = "/Users/alex";
  };
in
commonHome // {
  # Refer to the nixOS host for info about home-manager
  # inherit commonHome;

  home.stateVersion = "25.11";
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Window management (maybe configure it with home-manager)
    yabai
    skhd
    #borders
  ];
}
