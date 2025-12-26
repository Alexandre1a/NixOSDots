{ pkgs, ... }:

{
# Enpty file for future imports
  imports = [
    (import ../../modules/common/ai.nix { inherit pkgs; })
  ];
}
