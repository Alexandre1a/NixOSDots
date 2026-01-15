{ pkgs, inputs, config, ... }:
{
  imports = [
    #./modules.nix
  ];

  networking = {
    hostName = "light";
  };

  # Users
  # Don't forget to add a password or change the username
  users.users = {
      light = { # Here
        isNormalUser = true;
        # You can change the description too !
        description = "A lightweight system for lowend or performance machines";
        shell = pkgs.zsh;
        extraGroups = [ "networkmanager" "wheel" ];
      };
    };

  # Home-Manager config
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "HM-backup";
    users = {
      # Change this to your username
      "light" = import ./home.nix;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      wget
      git
    ];
  };

}
