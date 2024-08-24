{ inputs, config }:
final: prev: {
  go = prev.go.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "golang";
      repo = "go";
      rev = "go1.23.0";
      # If you don't know the hash, the first time, set:
      # hash = "";
      # then nix will fail the build with such an error message:
      # hash mismatch in fixed-output derivation '/nix/store/m1ga09c0z1a6n7rj8ky3s31dpgalsn0n-source':
      # specified: sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
      # got:    sha256-173gxk0ymiw94glyjzjizp8bv8g72gwkjhacigd1an09jshdrjb4
      hash = "sha256-Kcr637rG6CKbwI4lU/5RqGnnNjv9VmSgis70o2B1B3s=";
    };
  });  
}
