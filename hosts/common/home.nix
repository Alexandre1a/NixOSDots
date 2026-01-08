{ config, pkgs, inputs, ... }:

{

  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
    ../../modules/home-manager/spicetify.nix
    ../../modules/home-manager/zed.nix
    ../../modules/home-manager/shell.nix
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
  };


  # Common Packages
  home = {
    packages = with pkgs; [
      # CLI
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
    shellAliases = {
      drs = "darwin-rebuild switch --flake ~/Developer/nix/NixOSDots#macOS";
      nrb = "nixos-rebuild switch --flake ~/Developer/NixOSDots#nixos";
    };
  };
}
