{ lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      vesktop = prev.vesktop.overrideAttrs (_: {
        dontBuild = true;
        dontConfigure = true;

        src = pkgs.fetchzip {
          url = "https://github.com/Vencord/Vesktop/releases/download/v1.6.4/Vesktop-1.6.4-universal-mac.zip";
          sha256 = "a78d0abcecfb1c615b7bd3ebe0428b4ae9f8a6f6ffa6dd288bb42f69a440dfa";
        };

        installPhase = ''
          mkdir -p $out/Applications
          cp -R Vesktop.app $out/Applications/
        '';

        meta.platforms = [ "aarch64-darwin" ];
      });
    })
  ];
}

