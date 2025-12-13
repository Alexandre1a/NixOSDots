{ config, pkgs, ... }:

{
  # Refer to the nixOS host for info about home-manager
  home.username = "alex";
  home.homeDirectory = "/Users/alex";

  imports = [
    inputs.spicetify-nix.homeMamangerModules.spicetify
  ];

  home.stateVersion = "25.11";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    yt-dlp
    syncthing
    obsidian
    bitwarden-desktop
    # Window management (maybe configure it with home-manager)
    yabai
    skhd
    #borders

    # Dev
    doxygen
    autoconf
    pkg-config
    swig
    pandoc
    gh
    cmatrix
    iterm2
    vscode

    # Go
    hugo

    # JavaScript
    pnpm
    nodejs
    
    # C/CPP
    ninja
    cmake

    # Python
    python312
    
    # Customisation
    spicetify-cli
  ];
}
