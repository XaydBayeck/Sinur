{ lib
, pkgs
, stdenv
, fetchurl
, guile ? pkgs.guile_3_0
, pkg-config
, autoconf
, automake
#, guile-syntax-higlight
, texinfo
, guile-opengl
, guile-sdl2
, freetype
, libjpeg
, libpng
, libvorbis
, mpg123
, openal
, readline
, ...
}:

let
  lib' = lib // import ../../lib { inherit pkgs; };
in
stdenv.mkDerivation rec {
  pname = "chickadee";
  version = "0.10.0";
  src = fetchurl {
    url = "https://files.dthompson.us/${pname}/${pname}-${version}.tar.gz";
    sha256 = "sha256-Ey9TtuWaGlHG2cYYwqJIt2RX7XNUW28OGl/kuPUCD3U=";
  };

  nativeBuildInputs = [
    pkg-config
    autoconf
    automake
    texinfo
    #guile-syntax-higlight
  ];

  buildInputs = [
    guile
    freetype
    libjpeg
    libpng
    libvorbis
    mpg123
    openal
    readline
  ];

  propagatedBuildInputs = [
    guile-opengl
    guile-sdl2
  ];

  makeFlags = [ "GUILE_AUTO_COMPILE=0" ];

  meta = with lib'; {
    homepage = "https://dthompson.us/projects/${pname}.html";
    description = ''
      Chickadee is a game development toolkit for Guile
      Scheme.  It contains all of the basic components needed to develop
      2D/3D video games.
    '';
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ sid ];
    platform = platforms.linux;
  };
}
