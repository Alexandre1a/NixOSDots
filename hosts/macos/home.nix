{ config, pkgs, ... }:

let
  commonHome = import ../common/home.nix {
    inherit config pkgs inputs;
    username = "alex";
    homeDir = "/Users/alex";
  };
in
{
  # Refer to the nixOS host for info about home-manager
  inherit commonHome;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Window management (maybe configure it with home-manager)
    yabai
    skhd
    #borders
  ];
}
