{ pkgs, inputs, ... }:

{
  # Installs Spotify and Spicetify (import this module in configuration.nix)
  environment = {
    systemPackages = with pkgs; [
      spotify
    ];
  };

 
  networking = {
    firewall = {
      # Local discovery
      allowedTCPPorts = [ 57621 ];
      # Spotify Connect
      allowedUDPPorts = [ 5353 ];
    };
  };
}
