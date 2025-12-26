{ pkgs ,... }:

{
# Enpty file for future imports
  imports = [
    (import ../../common/ai.nix { inherit pkgs; })
  ];
}
