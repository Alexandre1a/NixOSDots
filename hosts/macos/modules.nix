{ pkgs, ... }:

{
# Enpty file for future imports
  imports = [
    ../../modules/macos/ollama.nix
    ../../modules/common/ai.nix
  ];
}
