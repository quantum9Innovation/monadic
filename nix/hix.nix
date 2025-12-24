{ pkgs, ... }:
{
  name = "monadic";
  compiler-nix-name = "ghc912"; # Version of GHC to use

  # Requires building some packages from source
  # crossPlatforms =
  #   p:
  #   pkgs.lib.optionals pkgs.stdenv.hostPlatform.isx86_64 (
  #     [
  #       p.mingwW64
  #       p.ghcjs
  #     ]
  #     ++ pkgs.lib.optionals pkgs.stdenv.hostPlatform.isLinux [
  #       p.musl64
  #     ]
  #   );

  # Tools to include in the development shell
  shell = {
    buildInputs = with pkgs; [
      z3
      just
      haskell-language-server
      watchexec
      live-server
    ];

    tools = {
      cabal = "latest";
      hlint = "latest";
      haskell-language-server = "latest";
      fourmolu = "0.19.0.1";
      hoogle = "latest";
      ghcid = "latest";
    };
  };
}
