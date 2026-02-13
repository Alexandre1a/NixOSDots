{
  description = "General Vulkan dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        python = pkgs.python314;
      in
      {
        devShells.default = pkgs.mkShell {
          name = "vulkan";

          packages = with pkgs; [
            shaderc
            vulkan-headers
            vulkan-loader
            vulkan-validation-layers
            vulkan-tools
            glfw
            cmake
          ];
          VK_LAYER_PATH = "${pkgs.vulkan-loader}/lib:${pkgs.shaderc.lib}/lib"
         
          shellHook = ''
            echo "Vulkan loaded"
          '';
        };
      });
}
