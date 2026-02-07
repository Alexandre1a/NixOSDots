{ pkgs, inputs, ... }:
let
  modules = import ../../modules;
in
{
  # This file is used to import all modules required by this setup.
  imports =
    [
      inputs.sops-nix.nixosModules.sops
      modules.common.module
      modules.nixos.secrets # Sops
#     ../../modules/nixos/wireless.nix # For the wifi
      ../../modules/nixos/gaming/nvidia.nix # Nvidia (Drivers and Settings)
      ../../modules/nixos/gaming/starCitizen.nix
      ../../modules/nixos/gaming/steam.nix # For Steam/Proton/Lutris/MangoHUD/Heroic/Bottles
      ../../modules/common/spotify.nix # Spotify
      ../../modules/common/ai.nix
    ];
}
