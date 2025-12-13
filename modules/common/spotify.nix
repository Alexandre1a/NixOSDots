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

  # Spicetify
  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in
  {
    enable = true;

    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      ncsVisualiser
    ];

    enabledSnippets = with spicePkgs.snippets; [
      rotatingCoverart
      pointer
    ];

    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  }
}
