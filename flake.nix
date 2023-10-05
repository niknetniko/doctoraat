{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devshell = {
      url = "github:numtide/devshell";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = { self, nixpkgs, devshell, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; overlays = [ devshell.overlays.default ]; };
      in
      {
        devShells = rec {
          default = site;
          site = pkgs.devshell.mkShell {
            name = "doctoraat";
            packages = with pkgs; [
              texlive.combined.scheme-full
              gnumake
              inkscape
            ];
            env = [
              {
                name = "TEXLIVE_HOME";
                eval = "${pkgs.texlive.combined.scheme-full}";
              }
            ];
          };
        };
      }
    );
}
