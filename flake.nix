{
  # This is a template created by `hix init`
  inputs = {
    haskellNix.url = "github:binary-star-systems/haskell.nix";
    nixpkgs.follows = "haskellNix/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    pre-commit.url = "github:cachix/git-hooks.nix";
    pre-commit.inputs.nixpkgs.follows = "nixpkgs";
    fourmolu.url = "git+https://code.functor.systems/functor.systems/fourmolu.git?ref=main";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      haskellNix,
      pre-commit,
      fourmolu,
    }:
    let
      supportedSystems = [
        "x86_64-linux"
      ];
    in
    flake-utils.lib.eachSystem supportedSystems (
      system:
      let
        overlays = [
          haskellNix.overlay
          (final: _prev: {
            haskell-nix = _prev.haskell-nix // {
              extraPkgconfigMappings = _prev.haskell-nix.extraPkgconfigMappings // {
                # String pkgconfig-depends names are mapped to lists of Nixpkgs
                # package names
                "z3" = [ "z3" ];
              };
            };
            hixProject = final.haskell-nix.hix.project {
              src = ./.;
            };
          })
        ];
        pkgs = import nixpkgs {
          inherit system overlays;
          inherit (haskellNix) config;
        };
        flake = pkgs.hixProject.flake { };
      in
      flake
      // {
        checks = {
          pre-commit-check = pre-commit.lib.${system}.run {
            src = ./.;
            hooks = {
              check-merge-conflicts.enable = true;
              commitizen.enable = true;
              convco.enable = true;
              cabal-gild.enable = true;
              hlint.enable = true;
              fourmolu = {
                enable = true;
                package = fourmolu.packages.${system}.default;
              };
              markdownlint.enable = true;
              mdsh.enable = true;
              deadnix.enable = true;
              nil.enable = true;
              nixfmt-rfc-style.enable = true;
              statix.enable = true;
              ripsecrets.enable = true;
              typos.enable = true;
              vale.enable = false;
              typstyle.enable = true;
              check-yaml.enable = true;
              yamlfmt.enable = true;
              check-case-conflicts.enable = true;
              check-executables-have-shebangs.enable = true;
              check-shebang-scripts-are-executable.enable = true;
              check-symlinks.enable = true;
              check-vcs-permalinks.enable = true;
              detect-private-keys.enable = true;
              end-of-file-fixer.enable = true;
              mixed-line-endings.enable = true;
              tagref.enable = true;
              trim-trailing-whitespace.enable = true;
              check-toml.enable = true;
            };
          };
        };

        devShells = {
          default =
            let
              buildInputs = builtins.concatStringsSep " " [
                "liquidhaskell"
                "liquid-prelude"
                "liquid-vector"
                "text"
                "hakyll"
                "filepath"
                "clay"
              ];
              flags = builtins.concatStringsSep " " (
                map (ext: "-X${ext}") [
                  "DerivingStrategies"
                  "OverloadedStrings"
                ]
              );
              dir = "src";
              main = "${dir}/Main.hs";
            in
            flake.devShells.default.overrideAttrs (_: {
              shellHook = ''
                alias install-liquid='cabal install --lib ${buildInputs} --package-env . --force-reinstalls'
                alias liquid='ghc -fplugin=LiquidHaskell -isrc ${main} ${flags}'
                alias watch-liquid='watchexec -r -e hs "ghc -fplugin=LiquidHaskell -isrc ${main} ${flags}"'
              '';
            });

          runner = nixpkgs.legacyPackages.${system}.mkShell {
            buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
            inherit (self.checks.${system}.pre-commit-check) shellHook;
          };
        };

        legacyPackages = pkgs;
        packages = flake.packages // {
          default = flake.packages."monadic:exe:monadic";
        };
      }
    );

  # --- Flake Local Nix Configuration ----------------------------
  nixConfig = {
    # This sets the flake to use the IOG nix cache.
    # Nix should ask for permission before using it,
    # but remove it here if you do not want it to.
    extra-substituters = [ "https://cache.iog.io" ];
    extra-trusted-public-keys = [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" ];
    allow-import-from-derivation = "true";
  };
}
