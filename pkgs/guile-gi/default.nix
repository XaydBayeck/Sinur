{ lib,
  pkgs,
  stdenv,
  fetchFromGitHub,
  glib,
  gobject-introspection,
  guile ? pkgs.guile_3_0,
  libtool,
  pkg-config,
  autoreconfHook,
  texinfo,
  gettext,
  ... }:

let
  name = "guile-gi";
  lib' = lib // import ../../lib { inherit pkgs; };
in
stdenv.mkDerivation {
  pname = name;
  version = "git";
  src = fetchFromGitHub {
    owner = "spk121";
    repo = name;
    rev = "388653ac9e95802d1a69c585aef1d60e35e6b71c";
    sha256 = "sha256-29Q8f7ex8LHIYGRF/KD89PXWXQ/DG6ucqG7J4t/Cv9k=";
  };

  nativeBuildInputs = [
    glib
    gobject-introspection
    libtool
    pkg-config
    autoreconfHook
    texinfo
    gettext
  ];

  buildInputs = [
    guile
    glib
  ];

  propagatedBuildInputs = [
    gobject-introspection
  ];

  preConfigure = ''
    ./bootstrap
  '';

  configureFlags = [
    "--with-gnu-filesystem-hierarchy"
    "--enable-hardening"
  ];

  meta = with lib'; {
    homepage = "https://github.com/spk121/guile-gi";
    description = "Bindings for GObject Introspection and libgirepository for Guile ";
    license = licenses.gpl3;
    maintainers = with maintainers; [ sid ];
    platform = platforms.linux;
  };
}
