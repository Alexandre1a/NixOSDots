{
  description = "General C++ dev enviroment";

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
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
        pname = "myapp";
        version = "0.1.0";
        src = self;
  
        nativeBuildInputs = with pkgs; [ cmake ninja ];
        buildInputs = with pkgs; [ ];
        };

	devShells.default = pkgs.mkShell {
          name = "cpp-dev";
          
          # In the dev shell, you get more tools than just what's needed to build
          packages = with pkgs; [
            gcc
            clang
            cmake
            ninja
            gdb
            valgrind
            clang-tools
            ccache
          ];
          
          shellHook = ''
            echo "C++ loaded"
            export CC="ccache gcc"
            export CXX="ccache g++"
          '';
        };
      });
}
