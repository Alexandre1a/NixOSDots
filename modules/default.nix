{
  common = {
    module = ../hosts/common/modules.nix;
    home = ../hosts/common/home.nix;
    ai = ./common/ai.nix;
    direnv = ./common/direnv.nix;
    environment = ./common/environment.nix;
    nix = ./common/nix.nix;
    spotify = ./common/spotify.nix;
    ssh = ./common/ssh.nix;
    zed2 = ./common/zed2.nix;
    zed = ./common/zed.nix;
  };

  hm = {
    hyprland = ./home-manager/Hyprland/hyprland.nix;
    scripts = ./home-manager/Hyprland/scripts.nix;
    nvim = ./home-manager/nvim.nix;
    shell = ./home-manager/shell.nix;
    spicetify = ./home-manager/spicetify.nix;
    zed = ./home-manager/zed.nix;
    zen = ./home-manager/zen.nix;
  };

  nixos = {
    desktop = {
      lightDM = ./nixos/desktop/lightDM.nix;
      xfce = ./nixos/desktop/xfce.nix;
    };
    gaming = {
      amd = ./nixos/gaming/amd.nix;
      nvidia = ./nixos/gaming/nvidia.nix;
      starCitizen = ./nixos/gaming/starCitizen.nix;
      steam = ./nixos/gaming/steam.nix;
      vr = ./nixos/gaming/vr.nix;
      mod = ./nixos/gaming/mod.nix;
    };

    bootloader = ./nixos/bootloader.nix;
    locale = ./nixos/locale.nix;
    secrets = ./nixos/secrets.nix;
    swap = ./nixos/swap.nix;
    wireless = ./nixos/wireless.nix;
  };

  macos = {
    ollama = ./macos/ollama.nix;
    vesktop = ./macos/vesktop.nix;
  };
}
