{ pkgs, inputs, ... }:

{
  # All imports go here
  imports =
    [
      ./modules.nix
      # HomeManager
      inputs.home-manager.darwinModules.default
    ];
  
  # All System packages
  environment.systemPackages = 
    [
      pkgs.vim
    ];
  
  # HomeManager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "alex" = import ./home.nix;
    };
  };
  # Use ZSH as the shell
  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
    };
  };
  # Enable required settings
  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Target arch
  nixpkgs.hostPlatform = "aarch64-darwin";
  # Nix-Darwin State Version
  system.stateVersion = 6;
}
