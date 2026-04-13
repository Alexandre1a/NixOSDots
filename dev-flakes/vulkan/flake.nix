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
      in {
        devShells.default = pkgs.mkShell {
          name = "vulkan";
          hardeningDisable = [ "fortify" ];

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
            # Wayland
            wayland
            wayland-protocols
            wayland-scanner
            libxkbcommon
            # Miniaudio
            libpulseaudio
            libpulseaudio.dev
            # Other libraries
            glfw3
            tinyobjloader
            nlohmann_json
            tinygltf
            stb
            glm
            cmake
            ninja
            pkg-config
            # Debug
            gdb
          ];
          # Environment Variables
          LD_LIBRARY_PATH = "${pkgs.vulkan-loader}/lib:${pkgs.shaderc.lib}/lib:${pkgs.libpulseaudio}/lib:${pkgs.libpulseaudio.dev}/lib";
          VK_LAYER_PATH = "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";
          VULKAN_SDK = "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";

          shellHook = ''
            echo "Vulkan loaded"
          '';
        };
      });
}
