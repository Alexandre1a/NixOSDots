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
            # Shader compile
            shader-slang
            glslang
            # Vulkan
            vulkan-headers
            vulkan-loader
            vulkan-validation-layers
            vulkan-tools
            vulkan-utility-libraries
            # Other libraries
            glfw3
            tinyobjloader
            glm
            cmake
            ninja
          ];
          # Environment Variables
          LD_LIBRARY_PATH = "${pkgs.vulkan-loader}/lib:${pkgs.shaderc.lib}/lib";
          VK_LAYER_PATH = "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";
          VULKAN_SDK = "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";

          shellHook = ''
            echo "Vulkan loaded"
          '';
        };
      });
}
