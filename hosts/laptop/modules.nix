let
  modules = import ../../modules;
in
{
  imports = [
    modules.common.module
    ./hardware-configuration.nix
    modules.nixos.gaming.steam
    modules.nixos.gaming.nvidia
  ];

}
