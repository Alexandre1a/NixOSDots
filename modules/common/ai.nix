{ pkgs, lib, config, ... }:

let

  hasNvidiaGpu = config.hardware.nvidia.package or null != null;

  gpu =
    if hasNvidiaGpu then
      pkgs.ollama-cuda
    else if builtins.hasAttr "vulkan" pkgs then
      pkgs.ollama-vulkan
    else if builtins.hasAttr "amd" pkgs then
      pkgs.ollama-rocm
    else if pkgs.stdenv.isDarwin then
      pkgs.ollama # Ollama uses Metal by default
    else
      pkgs.ollama; # CPU fallback
in
{
  services = {
    ollama = {
      enable = true;
      loadModels = [ "codegemma:7b-instruct" "codegemma:7b-code" "codegemma:2b" "starcoder2:7b" "deepseek-r1:14b" "deepseek-r1:8b" ];
      package = gpu;
    };
  };

}
