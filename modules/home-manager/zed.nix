{ pkgs, lib, ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "rust"

      "rosé pine"
      "catpuccin blur"
      
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
      theme = {
        mode = "system";
        dark = "Catpuccin Frappé (Blur)";
        light = "Rosé Pine Dawn";
      };
      hour_format = "hour24";
      language_models = {
        ollama = {
          api_url = "http://localhost:11434";

        };
      };
    };
  };
}
