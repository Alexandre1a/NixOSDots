{ pkgs, inputs, lib, ... }:

let
  helpers = pkgs.callPackage "${inputs.nix-cachyos-kernel.outPath}/helpers.nix" {};
  cachyKernel = pkgs.cachyosKernels.linux-cachyos-bore-lto.override {
    cpusched = "bore";
    lto  = "thin";
    processorOpt = "x86_64-v3";
    hzTicks = "1000";
    tickrate = "full";
    preemptType = "full";
    bbr3 = true;
    ccHarder = true;
    hugepage = "always";
  };
in {
  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
  boot.kernelPackages = helpers.kernelModuleLLVMOverride (
    pkgs.linuxKernel.packagesFor cachyKernel
  );
  nix.settings = {
    substituters = lib.mkAfter [
      "https://attic.xuyh0120.win/lantian"
    ];
    trusted-public-keys = lib.mkAfter [
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];
  };
}
