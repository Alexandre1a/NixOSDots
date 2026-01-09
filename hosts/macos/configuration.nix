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
        # Basic text editing for all users
        neovim
        vim
        # General tools
        btop
        eza
        fastfetch
        ffmpeg
        fzf
        git
        git-lfs
        gnupg
        wget
        tree
        netcat
        tmux
        #telnet
      ];
    pathsToLink = [ "/share/zsh" ];
  };
  # Create the user 
  users.users.alex = {
    description = "Alexandre Delcamp--Enache";
    home = "/Users/alex";
    shell = pkgs.zsh;
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
  security.pam.services.sudo_local.touchIdAuth = true;
  # Flakes
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
      ];
    
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };
  # Target arch
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = {
      allowUnfree = true;
    };
  };
  # Nix-Darwin State Version
  system = {
    stateVersion = 6;
    primaryUser = "alex";
  };
}
