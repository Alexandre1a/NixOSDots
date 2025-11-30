{ pkgs, ... }:

{
  # Steam
  programs = {
    steam = {
      enable = true;
      gamescopeSession = {
        enable = true;
      };
    };
    gamemode = {
      enable = true;
    };
  };

  # Proton GE
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "/home/alex/.steam/root/compatibilitytools.d";
  };

  # Programmes requis
  environment.systemPackages = with pkgs; [
    mangohud
    protonup-ng
    lutris
    heroic
    bottles
  ];
}
