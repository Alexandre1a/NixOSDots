{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      vesktop = prev.vesktop.overrideAttrs (old: {
        env = (old.env or {}) // {
          ELECTRON_BUILDER_DISABLE_SIGNING = "true";
        };
      });
    })
  ];
}
