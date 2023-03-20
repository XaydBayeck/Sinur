{ lib, stdenv, fetchurl, ... }:

let
  commit = "28ada26f4e926a741d8645cb8fa9d9d8ab3a3b70";
in
stdenv.mkDerivation rec {

  pname = "fcitx5-nord";
  version = "2021-7-27";
  src = fetchurl {
    url = "https://github.com/tonyfettes/fcitx5-nord/archive/${commit}/${pname}-${commit}.tar.gz";
    sha256 = "sha256-Wnlf/ZgoN4FCCs0oGppPA+db6hRVhVVJxHGQw7l82/w=";
  };

  installPhase = ''
    mkdir -p $out/share/fcitx5/themes/
    cp -r Nord-Dark/ Nord-Light/ $out/share/fcitx5/themes/
  '';

  meta = with lib; {
    homepage = "https://github.com/tonyfettes/fcitx5-nord";
    description = "Fcitx5 theme based on Nord color.";
    license = licenses.mit;
    maintainers = [ sid ];
    platform = platforms.linux;
  };
}
