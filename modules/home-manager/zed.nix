{ pkgs, lib, ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "rosé pine"
      "rust"
      "typescript"
      "python"
      "javascript"
      "html"
      "css"
      "markdown"
      "json"
      "yaml"
      "go"
    ];
    extraPackages = [ pkgs.nixd ];

    userSettings = {
      theme = "Dracula";
    };
  };
}
