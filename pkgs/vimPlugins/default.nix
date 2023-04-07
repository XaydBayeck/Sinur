{ buildNeovimPluginFrom2Nix, fetchFromGithub }:

let
  github = "https://github.com";
in
{
  idris2-nvim = buildNeovimPluginFrom2Nix {
    pname = "idris2-nvim";
    version = "22-11-2";
    src = fetchFromGithub {
      owner = "ShinKage";
      repo = "idris2-nvim";
      rev = "dd850c1c67bcacd2395121b0898374fe9cdd228f";
      sha256 = "";
    };

    meta.homepage = github + "ShinKage/idris2-nvim/";
  };
}
