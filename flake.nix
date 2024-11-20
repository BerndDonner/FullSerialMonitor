{
  description = "Javascript Development with Nix 24.05";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devShells.default = pkgs.mkShell {
          name = "impureJavascriptEnv";
          
          packages = with pkgs; [
            electron_33
            nodejs_22
            node2nix
            stdenv.cc.cc.lib
          ];
          buildInputs = with pkgs; [];
          
          # fixes libstdc++ issues and libgl.so issues
          LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib/";
        };
      };
    };

}

