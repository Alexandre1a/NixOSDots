let
  modules = import ../../modules;
in
{
    # Common nixos systems modules (not nix-darwin)
    imports = [
      modules.common.nix
      modules.common.direnv
      modules.nixos.swap
      modules.nixos.locale # For localisation options
      modules.common.ssh
      modules.nixos.bootloader
      modules.common.environment
    ];
}
