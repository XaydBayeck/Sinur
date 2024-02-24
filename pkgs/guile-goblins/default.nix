{ lib
, pkgs
, stdenv
, fetchurl
, guile ? pkgs.guile_3_0
, pkg-config
, autoreconfHook
, texinfo
, guile-gnutls
, guile-gcrypt
, guile-fibers
, ...
}:

let
  lib' = lib // import ../../lib { inherit pkgs; };
in
stdenv.mkDerivation rec {
  pname = "guile-goblins";
  version = "0.12.0";
  src = fetchurl {
    url = "https://spritely.institute/files/releases/${pname}/${pname}-${version}.tar.gz";
    sha256 = "sha256-P5WKKv5i5Lrs4en+IWL40AkYAD+bgTyFdsQqE4FxPfA=";
  };

  nativeBuildInputs = [
    pkg-config
    autoreconfHook
    texinfo
  ];

  buildInputs = [
    guile
  ];

  propagatedBuildInputs = [
    guile-gcrypt
    guile-fibers
    guile-gnutls
  ];

  makeFlags = [ "GUILE_AUTO_COMPILE=0" ];

  meta = with lib'; {
    homepage = "https://spritelyproject.org/";
    description = ''
      Spritely Goblins is a transactional, distributed object programming
      environment following object capability principles.  This is the guile version
      of the library!
    '';
    license = licenses.asl20;
    maintainers = with maintainers; [ sid ];
    platform = platforms.linux;
  };
}
