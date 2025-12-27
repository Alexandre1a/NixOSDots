{ config, pkgs, inputs, username, homeDir, ... }:

{
  home = {
    username = username;
    homeDirectory = homeDir;
  };

  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
    ../../modules/home-manager/spicetify.nix
  ];

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
    cava
    spicetify-cli
    # Dev CLI
    doxygen
    autoconf
    pkg-config
    swig
    pandoc
    gh

    # GUI apps
    zed-editor
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

    # C/C++
    clang-tools # The main compiler
    cmake
    vcpkg # The package manager

    # Python
    python312 # The main interpreter
    #pip # The package manager
  ];

  # Git config
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "mateialex@outlook.fr";
	name = "Alexandre";
      };
    };
  };
}
