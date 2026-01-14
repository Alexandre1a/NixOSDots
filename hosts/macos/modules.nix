{ pkgs, ... }:

{
# Enpty file for future imports
  imports = [
    ../../modules/common/nix.nix
    ../../modules/macos/ollama.nix
    ../../modules/common/ai.nix
  ];
}
