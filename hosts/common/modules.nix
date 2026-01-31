{
    # Common nixos systems modules (not nix-darwin)
    imports = [
      ../../modules/common/nix.nix
      ../../modules/common/direnv.nix
      ../../modules/nixos/swap.nix
      ../../modules/nixos/locale.nix # For localisation options
      ../../modules/common/ssh.nix
      ../../modules/nixos/bootloader.nix
      ../../modules/common/environment.nix
    ];
}
