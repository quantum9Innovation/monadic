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
                # string pkgconfig-depends names are mapped to lists of nixpkgs package names
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

        typst = pkgs.typst.withPackages (
          p: with p; [
            fletcher_0_5_8
            cetz_0_4_2
            oxifmt_0_2_1
            self.packages.${system}.html-math
          ]
        );
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

        devShells.runner = nixpkgs.legacyPackages.${system}.mkShell {
          buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
          inherit (self.checks.${system}.pre-commit-check) shellHook;
        };

        legacyPackages = pkgs;
        packages = flake.packages // {
          monadic-unwrapped = flake.packages."monadic:exe:monadic";
          monadic = pkgs.stdenvNoCC.mkDerivation {
            name = "monadic";
            src = self.packages.${system}.monadic-unwrapped;
            nativeBuildInputs = [ pkgs.makeWrapper ];
            installPhase = ''
              install -Dm755 ./bin/monadic $out/bin/monadic
              wrapProgram $out/bin/monadic \
                --prefix PATH : ${pkgs.lib.makeBinPath [ typst ]}
            '';
          };
          site = pkgs.stdenvNoCC.mkDerivation {
            name = "site";
            src = ./.;
            nativeBuildInputs = [ self.packages.${system}.monadic ];
            
            LANG = "en_US.UTF-8";
            LOCALE_ARCHIVE = pkgs.lib.optionalString (
              pkgs.stdenv.buildPlatform.libc == "glibc"
            ) "${pkgs.glibcLocales}/lib/locale/locale-archive";

            buildPhase = ''
              monadic build
            '';
            installPhase = ''
              mkdir -p $out
              mv ./_site/* $out
            '';
          };
          
          default = self.packages.${system}.monadic;
          html-math = pkgs.buildTypstPackage {
            pname = "html-math";
            version = "1.0.0";
            src = ./typst/pkgs/html-math/1.0.0;
          };
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
