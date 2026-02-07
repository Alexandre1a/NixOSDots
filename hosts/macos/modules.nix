{ pkgs, ... }:
let
  modules = import ../../modules;
in
{
# Enpty file for future imports
  imports = [
    modules.common.nix
    #../../modules/macos/vesktop.nix
    #../../modules/macos/ollama.nix
    modules.common.direnv
  ];
}
