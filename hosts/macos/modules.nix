{ pkgs, ... }:

{
# Enpty file for future imports
  imports = [
    ../common/modules.nix
    ../../modules/macos/ollama.nix
    ../../modules/common/ai.nix
  ];
}
