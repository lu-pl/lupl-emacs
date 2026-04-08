{
  description = "LUPL Emacs config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      lupl-emacs =
        (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages (epkgs: with epkgs; [
          vterm
          pdf-tools
        ]);
    in {
      packages.${system}.default = lupl-emacs;

      apps.${system}.default = {
        type = "app";
        program = "${lupl-emacs}/bin/emacs";
      };
    };
}
