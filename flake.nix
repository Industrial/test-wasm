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

      ruby = pkgs.ruby.overrideAttrs (attrs: {
        version = "3.2.2";
        src = pkgs.fetchurl {
          url = "https://cache.ruby-lang.org/pub/ruby/3.2/ruby-3.2.2.tar.gz";
          sha256 = "sha256-lsV1WIcaZ0jeW8nydOk/S1qtBs2PN776Do2U57ikI7w=";
        };
        patches = [];
        postPatch = "";
      });
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
          rubyPackages.rubocop
          bundix
          wasmtime
        ] ++ [
          ruby
        ];
      };
    }
  ));
}

