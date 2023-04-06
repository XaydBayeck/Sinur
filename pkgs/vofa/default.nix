{
  stdenv,
  fetchurl,
  autoPatchelfHook,
  # lib,
  makeWrapper,
  # callPackage,
  ...
}:

stdenv.mkDerivation rec {
  pname = "vofa+";
  version = "1.3.10";
  src = fetchurl {
    url = "https://je00.github.io/downloads/vofa+_${version}_amd64.deb";
    sha256 = "";
  };

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];

  unpackPhase = ''
    ar x ${src}
    tar xf data.tar.xz
  '';

  installPhase = ''
    mkdir -p $out
    mv opt $out/
    mv user/share $out/
  '';
}
