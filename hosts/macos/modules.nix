{ pkgs, ... }:

{
# Enpty file for future imports
  imports = [
    ../../modules/macos/ollama.nix
    (import ../../modules/common/ai.nix { inherit pkgs; })
  ];
}
