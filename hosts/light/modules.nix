{pkgs, ...}:

let
  modules = import ../../modules;
in
{
  imports = [
    ./hardware-configuration.nix
    modules.common.module
    modules.nixos.xfce # Desktop Enviroment 
  ];
}
