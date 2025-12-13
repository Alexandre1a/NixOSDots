{
  description = "Alexandre1a's nixOS and macOS config flake";

  inputs = {
    # NixPKGS unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";

    # Spicetify
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self,nix-darwin ,nixpkgs, ... }@inputs: {
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/nixos/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };

    darwinConfigurations.macOS = nix-darwin.lib.darwinSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/macos/configuration.nix
        inputs.home-manager.darwinModules.default
      ];
    };
  };
}
