{ pkgs, lib, ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "rust"

      "rosé pine"
      
      "typescript"
      "javascript"
      "html"
      "css"

      "go"
      "python"

      "json"
      "yaml"
      "toml"

      "markdown"      
    ];
    extraPackages = [ pkgs.nixd ];

    userSettings = {
      theme = "Dracula";
      language_models = {
        ollama = {
          api_url = http://localhost:11434";
          auto_discover = true;
        };
      };
    };
  };
}
