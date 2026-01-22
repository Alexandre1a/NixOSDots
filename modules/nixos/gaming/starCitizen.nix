{ pkgs, inputs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      inputs.nix-citizen.packages.${system}.rsi-launcher
    ];
  };
  programs = {
    rsi-launcher = {
      enable = true;

      preCommands = ''
        export MANGO_HUD=1;
      '';
    };
  }; 
}
