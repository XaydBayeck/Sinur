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
  version = "0.11.0";
  src = fetchurl {
    url = "https://spritely.institute/files/releases/${pname}/${pname}-${version}.tar.gz";
    sha256 = "sha256-1FD35xvayqC04oPdgts08DJl6PVnhc9K/Dr+NYtxhMU=";
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

  makeFlas = [ "GUILE_AUTO_COMPILE=0" ];

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
