{
  # Refer to the nixOS host for info about home-manager
  home.username = "alex";
  home.homeDirecotry = "/Users/alex";

  home.stateVersion = "25.11";

  home.packages = [
    pkgs.hello
  ];

  programs.home-manager.enable = true;

}
