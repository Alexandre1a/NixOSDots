{ lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      vesktop = prev.vesktop.overrideAttrs (_: {
        dontBuild = true;
        dontConfigure = true;

        nativeBuildInputs = [ pkgs.unzip ];

        src = pkgs.fetchzip {
          url = "https://github.com/Vencord/Vesktop/releases/download/v1.6.4/Vesktop-1.6.4-universal-mac.zip";
          sha256 = "sha256-Z5k9KXMTEglWAM0aNc+ATRGywKs9O43XgahTPf0hpyk=";
        };

        installPhase = ''
          mkdir -p $out/Applications
          unzip Vesktop-1.6.4-universal-mac.zip
          cp -R Vesktop.app $out/Applications/
        '';

        meta.platforms = [ "aarch64-darwin" ];
      });
    })
  ];
}

