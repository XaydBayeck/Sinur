# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:

{
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  example-package = pkgs.callPackage ./pkgs/example-package { };
  fcitx5-nord = pkgs.callPackage ./pkgs/fcitx5-nord { };
  rofiThemes = pkgs.callPackage ./pkgs/rofi-themes { };
  # vimPlugins = pkgs.callPackage ./pkgs/vimPlugins { };
  # some-qt5-package = pkgs.libsForQt5.callPackage ./pkgs/some-qt5-package { };
  guile-gi = pkgs.callPackage ./pkgs/guile-gi { guile = pkgs.guile_3_0; };
  guile-g-golf = pkgs.callPackage ./pkgs/guile-g-golf { guile = pkgs.guile_3_0; };
  guile-goblins = pkgs.callPackage ./pkgs/guile-goblins { guile = pkgs.guile_3_0; };
  guile-chickadee = pkgs.callPackage ./pkgs/guile-chickadee { guile = pkgs.guile_3_0; };
  # ...
}
