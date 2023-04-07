{ stdenv
, fetchurl
, autoPatchelfHook
, # lib,
  makeWrapper
, # callPackage,
  libxkbcommon
, pango
, libXext
, cairo
# , gdk-pixbuf
, dbus
, libglvnd
, libX11
, systemd
, # turn 2
  gtk3
, at-spi2-atk
, openssl_1_1
, libjpeg_original
, libICE
, libSM
, ...
}:

let
  libjpeg_original-v8d = libjpeg_original.overrideAttrs (old: rec {
    pname = "libjpeg-v8d";
    version = "8d";
    src = fetchurl {
      url = "http://www.ijg.org/files/jpegsrc.v${version}.tar.gz";
      sha256 = "sha256-/cTUwRM4rQKKfSP7U/W7k1RnE5Kmf7G1LgwypxIYkfg=";
    };
  });
  libraries = [
    libxkbcommon
    pango
    libXext
    cairo
    # gdk-pixbuf
    dbus
    libglvnd
    libX11
    systemd
    gtk3
    at-spi2-atk
    openssl_1_1
    libICE
    libSM
    libjpeg_original-v8d
  ];
in
stdenv.mkDerivation rec {
  pname = "vofa+";
  version = "1.3.10";
  src = fetchurl {
    url = "https://je00.github.io/downloads/vofa+_${version}_amd64.deb";
    sha256 = "sha256-uwQsWzpXd9gn53MfwAhAw9YbzUWoe6nFAt1UBkIR6AA=";
  };

  nativeBuildInputs = [ autoPatchelfHook makeWrapper ];
  buildInputs = libraries;

  unpackPhase = ''
    ar x ${src}
    tar xf data.tar.xz
  '';

  installPhase = ''
    mkdir -p $out
    mv opt $out/
    mv usr/share $out/

    # 替换菜单项目（desktop 文件）中的路径
    sed -i "s|Exec=.*|Exec=$out/opt/vofa+/vofa+|" $out/share/applications/*.desktop
    sed -i "s|Icon=.*|Icon=$out/opt/vofa+/vofa+.png|" $out/share/applications/*.desktop
  '';
}
