{ config, pkgs, inputs, ...}:

{
  imports = [
    ../common/home.nix
    ../../modules/home-manager/hyprland.nix
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
