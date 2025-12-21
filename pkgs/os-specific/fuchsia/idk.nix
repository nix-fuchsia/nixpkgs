{ fetchzip, pkgsBuildBuild, stdenvNoCC }:

let
  cpu = stdenvNoCC.hostPlatform.parsed.cpu.name;
  arch = if cpu == "x86_64" then
    "x64"
  else if cpu == "aarch64" then
    "arm64"
  else if cpu == "riscv64" then
    "riscv64"
  else
    throw "Unsupported architecture";
in

stdenvNoCC.mkDerivation {
  pname = "fuchsia-idk";
  version = "unstable-2025-12-21";
  src = fetchzip {
    url = "https://chrome-infra-packages.appspot.com/dl/fuchsia/sdk/core/linux-amd64/+/18ZvfJB61p7Z8HAaCWNp1P0ShDk7cryXpiqGaHIV6fUC#fuchsia.zip";
    hash = "sha256-vMP1VOX/GvUf2GgoGBMa9jdFdWRYuWvY3WzIj/DtU3Y=";
    stripRoot = false;
  };

  phases = [ "unpackPhase" "patchPhase" "installPhase" ];

  outputs = [
    "out"
    "libc"
  ];

  nativeBuildInput = with pkgsBuildBuild; [
    autoPatchelfHook
  ];

  installPhase = ''
    mkdir -p $out
    cp -r * $out/

    mkdir -p $libc
    cp -r arch/${arch}/sysroot/* $libc/
    mv $libc/dist/lib/* $libc/lib/
  '';
}
