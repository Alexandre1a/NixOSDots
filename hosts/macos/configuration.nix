{ config, pkgs, inputs, ... }:

{
  # All imports go here
  imports =
    [
      ./modules.nix 
      # HomeManager
      #inputs.home-manager.darwinModules.default
    ];
  
  # All System packages
  environment = { 
    systemPackages = with pkgs;
      [
        git-lfs
        #telnet
      ];
    pathsToLink = [ "/share/zsh" ];
  };
  # Create the user 
  users = {
    users = {
      alex = {
        description = "Alexandre Delcamp--Enache";
        home = "/Users/alex";
        shell = pkgs.zsh;
      };
    };
  };
  # HomeManager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
    ];
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
  # TouchID login
  security = {
    pam = {
      services = {
        sudo_local = {
          touchIdAuth = true;
        };
      };
    };
  };
  # Target arch
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
  };
  # Nix-Darwin State Version
  system = {
    stateVersion = 6;
    primaryUser = "alex";
  };
}
