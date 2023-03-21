{ lib, pkgs, stdenv, fetchFromGitHub, ... }:

let
  lib' = lib // import ../../lib { pkgs = pkgs; };
in
{
  rofiThemesCollection = stdenv.mkDerivation {
    pname = "rofi-themes-collection";
    version = "2021-11-27";
    src = fetchFromGitHub {
      owner = "newmanls";
      repo = "rofi-themes-collection";
      rev = "a1bfac5627cc01183fc5e0ff266f1528bd76a8d2";
      sha256 = "sha256-0/0jsoxEU93GdUPbvAbu2Alv47Uwom3zDzjHcm2aPxY=";
    };

    installPhase = ''
      mkdir -p $out/share/rofi/themes/
      cp themes/* $out/share/rofi/themes/
    '';

    meta = with lib'; {
      homepage = "https://github.com/newmanls/rofi-themes-collection";
      description = "Themes Collection for Rofi Launcher";
      license = licenses.gpl3;
      maintainers = with maintainers; [ sid ];
      platform = platforms.linux;
    };
  };
}
