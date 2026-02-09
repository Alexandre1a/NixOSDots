{
  common = {
    home = ../hosts/common/home.nix;
    module = ../hosts/common/modules.nix;
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
    shell = ./home-manager/shell.nix;
    spicetify = ./home-manager/spicetify.nix;
    zed = ./home-manager/zed.nix;
    zen = ./home-manager/zen.nix;
    nvim = ./home-manager/nvim.nix;
  };

  nixos = {
    gaming = {
      nvidia = ./nixos/gaming/nvidia.nix;
      amd = ./nixos/gaming/amd.nix;
      starCitizen = ./nixos/gaming/starCitizen.nix;
      steam = ./nixos/gaming/steam.nix;
      vr = ./nixos/gaming/vr.nix;
    };
    bootloader = ./nixos/bootloader.nix;
    locale = ./nixos/locale.nix;
    secrets = ./nixos/secrets.nix;
    swap = ./nixos/swap.nix;
    wireless = ./nixos/wireless.nix;
    xfce = ./nixos/xfce.nix;
  };

  macos = {
    ollama = ./macos/ollama.nix;
    vesktop = ./macos/vesktop.nix;
  };
}
