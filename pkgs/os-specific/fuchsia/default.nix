{
  makeScopeWithSplicing',
  generateSplicesForMkScope,
  fetchgit,
  lib,
  fetchurl,
}:

let
  otherSplices = generateSplicesForMkScope "fuchsia";
in
makeScopeWithSplicing' {
  inherit otherSplices;
  f =
    self:
    let
      callPackage = self.callPackage;

      # fuchsia-src = fetchgit {
      #   url = "https://fuchsia.googlesource.com/fuchsia";
      #   rev = "ecdfdf146dc0d653fbb3b941fb576373552ebfde";
      #   hash = "sha256-wfUH9T0l3m6HnIhFThBwpLylhgorPlzr/ntYoZI165Y=";
      #   fetchSubmodules = false;
      # };
    in
    rec {
      idk = callPackage ./idk.nix {
      };
      libc = idk.libc;
    };
}
