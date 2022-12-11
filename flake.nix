{
  inputs.haskellNix.url = "github:input-output-hk/haskell.nix";
  inputs.nixpkgs.follows = "haskellNix/nixpkgs-2111";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, haskellNix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [
          haskellNix.overlay (final: prev: {
            # This overlay adds our project to pkgs
            aoc2022Project =
              final.haskell-nix.cabalProject' {
                src = ./.;
                compiler-nix-name = "ghc8107";
                # This is used by `nix develop .` to open a shell for use with
                # `cabal`, `hlint` and `haskell-language-server`
                shell.tools = {
                  cabal = {};
                  hlint = {};
                  haskell-language-server = {};
                };
                # Non-Haskell shell tools go here
                shell.buildInputs = with pkgs; [
                  haskellPackages.implicit-hie
                ];
                # This adds `js-unknown-ghcjs-cabal` to the shell.
                # shell.crossPlatforms = ps: [ps.ghcjs];
              };
          })
        ];
        pkgs = import nixpkgs { inherit system overlays; inherit (haskellNix) config; };
        flake = pkgs.aoc2022Project.flake {
          # This adds support for `nix build .#js-unknown-ghcjs:hello:exe:hello`
          # crossPlatforms = ps: [ps.ghcjs];
        };
      in flake // {
        # Built by `nix build .`
        defaultPackage = flake.packages."aoc2022:exe:day1";
        formatter = pkgs.nixpkgs-fmt;
      }
    );
}
