{ pkgs, inputs, ... }:
let
  modules = import ../../modules;
in
{
  # This file is used to import all modules required by this setup.
  imports =
    [
      ./hardware-configuration.nix
      inputs.sops-nix.nixosModules.sops
      modules.common.module
      modules.nixos.secrets # Sops
#     ../../modules/nixos/wireless.nix # For the wifi
      modules.nixos.gaming.nvidia # Nvidia (Drivers and Settings)
      modules.nixos.gaming.starCitizen
      modules.nixos.gaming.steam # For Steam/Proton/Lutris/MangoHUD/Heroic/Bottles
      modules.common.spotify # Spotify
      modules.common.ai
    ];
}
