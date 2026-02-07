{ inputs, ...}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.sops-nix.nixosModules.sops
    ../common/modules.nix
    ../../modules/nixos/secrets.nix
    ../../modules/nixos/gaming/starCitizen.nix
    ../../modules/nixos/gaming/steam.nix
    ../../modules/common/spotify.nix
  ];
}
