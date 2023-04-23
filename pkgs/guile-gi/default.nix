{ lib,
  pkgs,
  stdenv,
  fetchFromGitHub,
  glib,
  gobject-introspection,
  guile ? pkgs.guile_3_0,
  libtool,
  pkg-config,
  autoconf,
  automake,
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
    rev = "ea5d0514a4b8c61b8e5eeafa2189eacc6e8fd83f";
    sha256 = "sha256-B7IzqMuQnM1VjtMzlc+y1/jE+qEsdkWZLcH9idAFa0A=";
  };

  nativeBuildInputs = [
    glib
    gobject-introspection
    libtool
    pkg-config
    autoconf
    automake
    texinfo
    gettext
  ];

  buildInputs = [
    guile
    glib
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
