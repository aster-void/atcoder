{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        cargo-compete = import ./nix/cargo-compete.nix pkgs;
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            cargo
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
