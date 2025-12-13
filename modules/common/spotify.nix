{ pkgs, inputs, ... }:

{
  # Installs Spotify and Spicetify (import this module in homeManager)
  environment.systemPackages = with pkgs; [
    spotify
  ];

  # Local discovery
  networking.firewall.allowedTCPPorts = [ 57621 ];

  # Spotify Connect
  networking.firewall.allowedUDPPorts = [ 5353 ];
}
