{ config, pkgs, inputs, ... }:

{

  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
    ../../modules/home-manager/spicetify.nix
    ../../modules/home-manager/secrets.nix
    ../../modules/common/zed.nix
  ];


  programs = {
    # Git config
    git = {
      enable = true;
      settings = {
        user = {
          email = "mateialex@outlook.fr";
          name = "Alexandre";
        };
      };
    };
    sops = {
      enable = true;
      defaultSopsFile = ../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
      age = {
        enable = true;
        keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      };
    # Zed config
    zed-custom = {
      enable = true;
    };
  };


  # Common Packages
  home.packages = with pkgs; [
    # CLI
    sops
    btop
    hello
    fastfetch
    yt-dlp
    syncthing # ToDo: configure it ig
    cmatrix
    spicetify-cli
    # Dev CLI
    doxygen
    autoconf
    pkg-config
    swig
    pandoc
    gh

    # GUI apps
    vscode
    vesktop
    obsidian
    bitwarden-desktop
    kitty # Terminal emulator but needs a GUI

    # Go
    go # The main compiler
    hugo

    # JavaScript
    nodejs # The main interpreter
    pnpm # To replace npm
    nodejs_22

    # C/C++
    clang-tools # The main compiler
    cmake
    vcpkg # The package manager

    # Python
    python312 # The main interpreter
    #pip # The package manager
  ];
}
