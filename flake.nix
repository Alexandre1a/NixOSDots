{
  description = "Alexandre1a's nixOS and macOS config flake";

  inputs = {
    # NixPKGS unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    awww = {
      url = "git+https://codeberg.org/LGFae/awww";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Spicetify
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Sops-nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Star citizen
    nix-citizen = {
     url = "github:Alexandre1a/nix-citizen";
     inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim =  {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nix-darwin ,nixpkgs, ... }@inputs: {
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/nixos/configuration.nix
        inputs.home-manager.nixosModules.default
        inputs.sops-nix.nixosModules.sops
      ];
    };

    nixosConfigurations.framework = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
      	inputs.nixos-hardware.nixosModules.framework-16-7040-amd
        inputs.lanzaboote.nixosModules.lanzaboote
        ./hosts/framework/configuration.nix
        inputs.home-manager.nixosModules.default
        inputs.sops-nix.nixosModules.sops
      ];
    };
    
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/laptop/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };

    nixosConfigurations.light = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/light/configuration.nix
        inputs.home-manager.nixosModules.default
        inputs.sops-nix.nixosModules.sops
      ];
    };

    darwinConfigurations.macOS = nix-darwin.lib.darwinSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/macos/configuration.nix
        inputs.home-manager.darwinModules.default
        inputs.sops-nix.darwinModules.sops
      ];
    };
  };
}
