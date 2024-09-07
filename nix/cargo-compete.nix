pkgs:
let
  cargo-compete = pkgs.rustPlatform.buildRustPackage {
    pname = "cargo-compete";
    version = "0.10.7";

    buildInputs = with pkgs; [
      openssl
      pkg-config
    ];
    nativeBuildInputs = with pkgs; [
      openssl
      pkg-config
    ];

    src = pkgs.fetchurl {
      url = "https://github.com/qryxip/cargo-compete/archive/refs/tags/v0.10.7.tar.gz";
      hash = "sha256-1KukT6Tr58LPN22vmoaRI8/DALJehEx3hswkMZnFk+c=";
    };

    cargoHash = "sha256-gj+UiYVViYEYupboYqVBypkt8fpt7WBv04+Tjy/qeQc=";
    doCheck = false;
  };
in
cargo-compete
