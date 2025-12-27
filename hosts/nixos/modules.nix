{ pkgs, inputs, ... }:

{
  # This file is used to import all modules required by this setup.
  imports = 
    [
      inputs.sops-nix.nixosModules.sops
      ../../modules/nixos/wireless.nix # For the wifi
      ../../modules/nixos/locale.nix # For localisation options
      ../../modules/nixos/gamming/nvidia.nix # Nvidia (Drivers and Settings)
      ../../modules/nixos/gamming/steam.nix # For Steam/Proton/Lutris/MangoHUD/Heroic/Bottles
      ../../modules/common/spotify.nix # Spotify/Spicetify
      ../../modules/common/ssh.nix
      (import ../../modules/common/ai.nix { inherit pkgs; })
    ];
}
