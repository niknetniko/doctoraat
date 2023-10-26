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
        pkgs = import nixpkgs { inherit system; overlays = [ devshell.overlays.default ]; config.allowUnfree = true; };
        ugent2016 = pkgs.stdenvNoCC.mkDerivation (finalAttrs: rec {
            pname = "ugent2016";
            version = "0.10.0";
            passthru = {
              pkgs = [ finalAttrs.finalPackage ];
              tlDeps = with pkgs.texlive; [
                etoolbox
                kvoptions
                xstring
                auxhook
                translations
                fontspec
                pgf
                textcase
                graphics
                geometry
                setspace
                ulem
              ];
              tlType = "run";
            };

            src = pkgs.fetchurl {
              url = "https://github.com/niknetniko/ugent2016/releases/download/${version}/ugent2016.zip";
              hash = "sha256-70/5WHljZwbB//CiKy5AKuVTpwyK2BmbPD/Z4lQwPc8=";
            };

            nativeBuildInputs = [ pkgs.unzip ];

            sourceRoot = ".";

            dontConfigure = true;
            dontBuild = true;

            installPhase = ''
              runHook preInstall

              mkdir -p $out
              unzip ugent2016.tds -d $out

              runHook postInstall
            '';

            dontFixup = true;

            meta = with pkgs.lib; {
              description = "Styles for UGent";
              license = licenses.unfreeRedistributable;
              maintainers = [ ];
              platforms = platforms.all;
            };
        });
        latex_with_ugent = pkgs.texlive.combine {
          inherit (pkgs.texlive) scheme-full;
          inherit ugent2016;
        };
      in
      {
        devShells = rec {
          default = site;
          site = pkgs.devshell.mkShell {
            name = "doctoraat";
            packages = with pkgs; [
              latex_with_ugent
              gnumake
              inkscape
            ];
            env = [
              {
                name = "TEXLIVE_HOME";
                eval = "${latex_with_ugent}";
              }
            ];
          };
        };
      }
    );
}
