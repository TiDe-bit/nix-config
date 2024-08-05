{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "last-words";
  version = "v1.0.0-beta.1";
  cargoLock = {
    lockFile = ./Cargo.lock;
  };
  src = fetchFromGitHub {
    owner = "TiDe-bit";
    repo = pname;
    rev = version;
    hash = lib.fakeHash;
  };

  cargoHash = lib.fakeHash;
  
  meta = {
    description = "A simple tool to capture the logs of docker containers.";
    homepage = "https://github.com/TiDe-bit/last-words";
    license = lib.licenses.unlicense;
    maintainers = [];
  };
}
