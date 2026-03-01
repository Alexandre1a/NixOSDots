{ inputs, ...}:
let
  modules = import ../../modules;
in
{
  imports = [
    ./hardware-configuration.nix
    inputs.sops-nix.nixosModules.sops
    modules.nixos.secureboot
    modules.common.module
    modules.nixos.secrets
    modules.nixos.gaming.amd
    modules.nixos.gaming.starCitizen
    modules.nixos.gaming.steam
    modules.nixos.gaming.vr
    modules.nixos.gaming.mod
    modules.common.spotify
  ];
}
