{ config, pkgs, inputs, ... }:

let 
  modules = import ../../modules;
in
{

  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
    modules.hm.spicetify
    modules.hm.zed
    modules.hm.zen
    modules.hm.nvim
    modules.hm.shell
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
      hello
      yt-dlp
      syncthing # ToDo: configure it ig
      spicetify-cli
      # Dev CLI
      doxygen
      autoconf
      pkg-config
      swig
      pandoc

      # GUI apps
      vscode
      vesktop
      obsidian
      beeper
      bitwarden-desktop
      kitty # Terminal emulator but needs a GUI

      # Go
      go # The main compiler
      hugo

      # JavaScript
      #nodejs_24 # The main interpreter
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
      drs = "sudo darwin-rebuild switch --flake ~/Developer/nix/NixOSDots#macOS";
      nrs = "sudo nixos-rebuild switch --flake ~/Developer/nix/NixOSDots#nixos";
      frs = "sudo nixos-rebuild switch --flake ~/Developer/nix/NixOSDots#framework";
      lrs = "sudo nixos-rebuild switch --flake ~/Developer/nix/NixOSDots#light";
      lars = "sudo nixos-rebuild switch --flake ~/Developer/nix/NixOSDots#laptop";
      cdd = "cd ~/Developer/nix/NixOSDots";
      ncg = "nix-collect-garbage -d";
      nfu = "nix flake update --flake ~/Developer/nix/NixOSDots";
    };
  };
}
