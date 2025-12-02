{
  # This file is used to import all modules required by this setup.
  imports = 
    [
      ../../modules/nixos/wireless.nix # For the wifi
      ../../modules/nixos/locale.nix # For localisation options
      ../../modules/nixos/gamming/nvidia.nix # Nvidia (Drivers and Settings)
      ../../modules/nixos/gamming/steam.nix # For Steam/Proton/Lutris/MangoHUD/Heroic/Bottles
    ];
}
