{
  description = "CV flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            gnumake

            (texliveSmall.withPackages (ps: with ps; [
              latexmk
              biber
              # packages used by cv.tex
              collection-latexrecommended
              biblatex
              csquotes
              fontawesome5
              enumitem
              titlesec
              supertabular
              multirow
              parskip
              xcolor
              geometry
              hyperref
              url
            ]))
          ];
        };
      }
    );
}
