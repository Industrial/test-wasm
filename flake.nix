{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat.url = "github:edolstra/flake-compat";
    ghc-wasm-meta.url = "git+https://gitlab.haskell.org/ghc/ghc-wasm-meta.git";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    flake-compat,
    ghc-wasm-meta
  } @ inputs: let
    inherit (nixpkgs) lib;
    inherit (lib) recursiveUpdate;
    inherit (flake-utils.lib) eachDefaultSystem defaultSystems;

    nixpkgsFor = lib.genAttrs defaultSystems (system:
      import nixpkgs {
        inherit system;
      });
  in (eachDefaultSystem (
    system: let
      pkgs = nixpkgsFor.${system};
    in {
      devShell = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          bashInteractive
        ];
        buildInputs = with pkgs; [
          (inputs.ghc-wasm-meta.packages.x86_64-linux.all_gmp)
          git
          nodejs-19_x
          nodejs-19_x.pkgs.eslint
          nodejs-19_x.pkgs.pnpm
          nodejs-19_x.pkgs.typescript
          wasmer
          wasmtime
          ihp-new
          zlib.dev
          zlib.out
        ];
      };
    }
  ));
}
