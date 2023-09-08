{ lib,
  pkgs,
  stdenv,
  fetchurl,
  glib,
  gobject-introspection,
  guile ? pkgs.guile_3_0,
  guile-lib,
  libtool,
  autoreconfHook,
  texinfo,
  gettext,
  pkg-config,
  gtk3,
  clutter,
  ... }:

let 
  lib' = lib // import ../../lib { inherit pkgs; };
in
stdenv.mkDerivation rec {
  pname = "g-golf";
  version = "0.8.0-a.5";
  src = fetchurl {
    url = "https://git.savannah.gnu.org/cgit/${pname}.git/snapshot/${pname}-${version}.tar.gz";
    sha256 = "sha256-jD/GcJdVXkwLyvL9PSpllLTlxBsV28qQ2W1nbcPvm9Y=";
  };

  nativeBuildInputs = [
    libtool
    pkg-config
    gettext
    autoreconfHook
    texinfo
    gobject-introspection
    glib
    gtk3
    clutter
  ];

  buildInputs = [
    guile
    guile-lib
    glib
  ];

  propagatedBuildInputs = [
    gobject-introspection
  ];

  preAutoreconf =
    let
      gir = "libgirepository-1.0";
      lg = "libglib-2.0";
      gob = "libgobject-2.0";
      ngir = "${gobject-introspection}/lib/${gir}.so";
      nlg = "${glib.out}/lib/${lg}.so";
      ngob = "${glib.out}/lib/${gob}.so";
      init-scm = "g-golf/init.scm";
    in
      ''
    mkdir build-aux
    touch build-aux/config.rpath

    sed -i 's|SITEDIR=.*$|SITEDIR=\"$datadir/guile/site/$GUILE_EFFECTIVE_VERSION\";\n|' configure.ac
    sed -i 's|SITECCACHEDIR="$libdir/g-golf/|SITECCACHEDIR="$libdir/|' configure.ac
    
    sed -i 's|\"/dev/tty\"|\"/dev/null\"|' test-suite/tests/gobject.scm

    sed -i 's|${gir}|${ngir}|' ${init-scm}
    sed -i 's|${lg}|${nlg}|' ${init-scm}
    sed -i 's|${gob}|${ngob}|' ${init-scm}
    sed -i 's|(dynamic-link \"libg-golf\")|(catch #t (lambda () (dynamic-link \"libg-golf\")) (lambda _ (dynamic-link \"$out/lib/libg-golf\")))|' ${init-scm}

    export GUILE_AUTO_COMPILE=0
  '';

  preCheck = ''
  Xvfb :1 &
  export DISPLAY=:1
  '';

  configureFlags = [
   "--with-guile-site=no"
  ];

  meta = with lib'; {
    homepage = "https://www.gnu.org/software/${pname}/";
    description = "G-Golf is a Guile Object Library for GNOME.";
    license = licenses.gpl3;
    maintainers = with maintainers; [ sid ];
    platform = platforms.linux;
  };
}
