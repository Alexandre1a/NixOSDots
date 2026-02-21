{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-citizen.nixosModules.default
  ];
  
  /*
  environment = {
    systemPackages = with pkgs; [
      inputs.nix-citizen.packages.${system}.rsi-launcher
      inputs.nix-citizen.packages.${system}.lug-helper
    ];
  };
  */
  programs = {
    rsi-launcher = {
      enable = true;
      includeOverlay = true;

      preCommands = ''
        export MANGO_HUD=1;
      '';
    };
  }; 
}
