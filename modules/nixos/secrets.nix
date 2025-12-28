{ config, ... }:

{
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "${config.home-manager.users.alex.home.homeDirectory}/.config/sops/age/keys.txt";
  };
}
