{ pkgs, ... }:

let
  # Détection simple du GPU pour choisir le package Ollama
  gpu =
    if builtins.hasAttr "nvidia" pkgs then
      pkgs.ollama-cuda
    else if builtins.hasAttr "vulkan" pkgs then
      pkgs.ollama-vulkan
    else if builtins.hasAttr "rocm" pkgs then
      pkgs.ollama-rocm
    else
      pkgs.ollama; # CPU fallback
in
{
  services = {
    ollama = {
      enable = true;
      loadModels = [ "codegemma:7b-instruct" "codegemma:7b-code" "codegemma:2b" "starcoder2:7b" ];
      package = gpu;
    };
    open-webui = {
      enable = true;
    };
  };

}
