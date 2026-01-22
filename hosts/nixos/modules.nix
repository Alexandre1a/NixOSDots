{ pkgs, inputs, ... }:

{
  # This file is used to import all modules required by this setup.
  imports =
    [
      inputs.sops-nix.nixosModules.sops
      ../common/modules.nix
      ../../modules/nixos/secrets.nix # Sops
#     ../../modules/nixos/wireless.nix # For the wifi
      ../../modules/nixos/gaming/nvidia.nix # Nvidia (Drivers and Settings)
      ../../modules/nixos/gaming/starCitizen.nix
      ../../modules/nixos/gaming/steam.nix # For Steam/Proton/Lutris/MangoHUD/Heroic/Bottles
      ../../modules/common/spotify.nix # Spotify
      ../../modules/common/ai.nix
    ];
}
