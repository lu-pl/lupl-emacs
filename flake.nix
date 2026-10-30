{
  description = "LUPL Emacs: Emacs with every use-package package built by Nix.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, emacs-overlay }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ emacs-overlay.overlays.default ];
      };
      lib = pkgs.lib;

      # Emacs plus every package the config declares; reads the config from
      # ~/.emacs.d at runtime like any other Emacs.
      emacs = pkgs.emacsWithPackagesFromUsePackage {
        package = pkgs.emacs;
        # init.el only `require`s the modules, which the use-package parser doesn't
        # follow, so feed it all the files concatenated.
        config = lib.concatMapStringsSep "\n" builtins.readFile
          ([ ./init.el ] ++ lib.filter (lib.hasSuffix ".el") (lib.filesystem.listFilesRecursive ./modules));
        # init.el sets use-package-always-ensure; built-ins are marked :ensure nil.
        alwaysEnsure = true;
        # Declared :ensure nil in the config because they need native parts from Nix.
        extraEmacsPackages = epkgs: [
          epkgs.vterm
          epkgs.pdf-tools
        ];
      };

      # Load the whole config in batch mode; fails if any form errors or if
      # use-package wants a package the Nix build doesn't provide.
      check = pkgs.runCommand "lupl-emacs-config-check" { } ''
        export HOME=$TMPDIR
        cp -r ${self} $TMPDIR/config
        chmod -R u+w $TMPDIR/config
        ${emacs}/bin/emacs --batch --init-directory=$TMPDIR/config \
          --eval '(setq native-comp-jit-compilation nil)' \
          -l $TMPDIR/config/init.el \
          --eval '(when lupl/nix-missing-packages
                    (message "Not provided by the Nix build: %S" lupl/nix-missing-packages)
                    (kill-emacs 1))'
        touch $out
      '';
    in
    {
      # Strict: only builds if the config loads cleanly with exactly these packages.
      # (`: ${check}` does nothing at build time; referencing it makes the check a
      # build dependency.) External tools (language servers etc.) are not bundled;
      # they come from PATH, e.g. a project's dev shell via envrc.
      packages.x86_64-linux.default = pkgs.symlinkJoin {
        name = "lupl-emacs-${pkgs.emacs.version}";
        paths = [ emacs ];
        postBuild = ": ${check}";
        meta.mainProgram = "emacs";
      };

      checks.x86_64-linux.default = check;
    };
}
