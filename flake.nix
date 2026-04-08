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

    lupl-emacs-app = pkgs.writeShellScriptBin "lupl-emacs" ''
      exec ${lupl-emacs}/bin/emacs --init-directory ${self} "$@"
    '';
  in {
    packages.${system}.default = lupl-emacs;

    apps.${system}.default = {
      type = "app";
      program = "${lupl-emacs-app}/bin/lupl-emacs";
    };
  };
}
