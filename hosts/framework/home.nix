{config, pkgs, inputs, ...}:

let
  modules = import ../../modules;
in 
{
  imports = [
    modules.common.home
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
