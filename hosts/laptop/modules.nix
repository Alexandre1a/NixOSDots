let
  modules = import ../../modules;
in
{
  imports = [
    ./hardware-configuration.nix
    modules.common.module
    modules.nixos.gaming.steam
    modules.nixos.gaming.nvidia
    modules.nixos.desktop.bluetooth
  ];

}
