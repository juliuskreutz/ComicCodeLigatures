{
  description = "Comic Code Ligatures";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      comic-code-ligatures = pkgs.stdenv.mkDerivation {
        pname = "comic-code-ligatures";
        version = "1";

        src = nixpkgs.lib.sourceFilesBySuffices ./. [".otf"];

        installPhase = ''
          runHook preInstall

          mkdir -p $out/share/fonts/opentype/
          mv *.otf $out/share/fonts/opentype/

          runHook postInstall
        '';
      };
    in {
      packages.default = comic-code-ligatures;
      packages.comic-code-ligatures = comic-code-ligatures;
    });
}
