{ rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "qlue-ls";
  version = "2.5.3";

  src = fetchFromGitHub {
    owner = "IoannisNezis";
    repo = "Qlue-ls";
    rev = version;
    hash = "sha256-pt/fR0JAsQO9EeIjLTiwKdpx9gusC4HaDcybhh1glrE="; 
  };

  cargoHash = "sha256-JoJHU05ZPO7WcBSMsecBdZjxDDga8WlDiViFgF764sU=";

  doCheck = false;
}
