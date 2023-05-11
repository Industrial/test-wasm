{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    flake-compat,
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
          git
          nodejs-19_x
          nodejs-19_x.pkgs.eslint
          nodejs-19_x.pkgs.pnpm
          nodejs-19_x.pkgs.typescript
          openssl
          ruby_3_1
          rubyPackages_3_1.rubocop
          bundix
        ];
      };
    }
  ));
}

