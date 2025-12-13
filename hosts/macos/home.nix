{
  # Refer to the nixOS host for info about home-manager
  home.username = "alex";
  home.homeDirectory = "/Users/alex";

  imports = [
    inputs.spicetify-nix.homeMamangerModules.spicetify
  ];

  home.stateVersion = "25.11";

  home.packages = [
    pkgs.hello
  ];
}
