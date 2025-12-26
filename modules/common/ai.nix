{ gpu, ... }:

{
  services = {
    ollama = {
      enable = true;
      loadModels = [ "codegemma:7b-instruct" "codegemma:7b-code" "codegemma:2b" "starcoder2:7b" ];
      acceleration = gpu;
    };
    open-webui = {
      enable = true;
    };
  };

}
