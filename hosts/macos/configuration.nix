{ pkgs, ... }:

{
  # All imports go here
  imports =
    [
      ./modules.nix
    ];
  
  # All System packages
  environment.systemPackages = 
    [
      pkgs.vim
    ];
        
  # Enable required settings
  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Target arch
  nixpkgs.hostPlatform = "aarch64-darwin";
  # Nix-Darwin State Version
  system.stateVersion = 6;
}
