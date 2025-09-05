{
  stdenv,
  lib,
  fetchurl,
  autoPatchelfHook,
  glibc,
}:
stdenv.mkDerivation {
  name = "sipctl";

  src = fetchurl {
    url = "https://tools.vseth.ethz.ch/sipctl/linux-amd64/sipctl";
    hash = "sha256-L72ELySK0SU34vpxC9fx8regwOH3e5eX4gaKh6xEsas=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [ glibc ];

  dontUnpack = true;

  installPhase = ''
    install -m755 -D $src $out/bin/sipctl
  '';

  meta = with lib; {
    homepage = "https://tools.vseth.ethz.ch/sipctl/linux-amd64/";
    description = "sipctl";
    platforms = platforms.linux;
  };
}
