{
  description = "Web dev + Go";

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
        devShells.default = pkgs.mkShell {
         # In the dev shell, you get more tools than just what's needed to build
          packages = with pkgs; [
            go
            gopls
            gotools
            air
            sqlite
            sqlitebrowser
            gcc
          ];

          # Variables
          CGO_ENABLED = "1";
          
          shellHook = ''
            echo "Go loaded"
            echo "air            -> Hot reload" 
            echo "sqlite3 app.db -> Inspect the DataBase"
            export PORT="8080"
          '';
        };
      });
}
