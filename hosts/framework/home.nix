{config, pkgs, inputs, ...}:

let
  modules = import ../../modules;
in 
{
  imports = [
    ../common/home.nix
    modules.hm.hyprland
  ];

  home = {
    stateVersion = "25.11";
    packages = with pkgs; [
    ];
    file = {

    };

    sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
