{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fenix.url = "github:nix-community/fenix";
  };

  outputs = { nixpkgs, flake-utils, fenix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        cargo-compete = import ./nix/cargo-compete.nix pkgs;
        toolchain = import ./nix/fenix.nix { inherit system fenix; };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            toolchain
            cargo-compete
          ];

          shellHook = ''
            export CARGO=`which cargo`
            alias ccp="cargo-compete compete"
          '';
        };
      }
    );
}
