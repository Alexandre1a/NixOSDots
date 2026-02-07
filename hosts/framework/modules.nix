{ inputs, ...}:
let
  modules = import ../../modules;
in
{
  imports = [
    ./hardware-configuration.nix
    inputs.sops-nix.nixosModules.sops
    modules.common.module
    modules.nixos.secrets
    modules.nixos.gaming.starCitizen
    modules.nixos.gaming.steam
    modules.common.spotify
  ];
}
