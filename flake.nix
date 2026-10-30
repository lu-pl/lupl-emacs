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
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];

      forAllSystems = f: nixpkgs.lib.genAttrs systems (system:
        f (import nixpkgs {
          inherit system;
          overlays = [ emacs-overlay.overlays.default ];
        }));

      # init.el only `require`s the modules, which the use-package parser doesn't follow,
      # so feed it all the files concatenated.
      configText = lib:
        lib.concatMapStringsSep "\n" builtins.readFile
          ([ ./init.el ] ++ lib.filter (lib.hasSuffix ".el") (lib.filesystem.listFilesRecursive ./modules));

      # Emacs plus every package the config declares; reads the config from
      # ~/.emacs.d (or --init-directory) at runtime like any other Emacs.
      emacsFor = pkgs: pkgs.emacsWithPackagesFromUsePackage {
        package = pkgs.emacs;
        config = configText pkgs.lib;
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
      checkFor = pkgs: emacs: pkgs.runCommand "lupl-emacs-config-check" { } ''
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
      packages = forAllSystems (pkgs:
        let
          emacs = emacsFor pkgs;
          check = checkFor pkgs emacs;
        in
        {
          # Strict: only builds if the config loads cleanly with exactly these packages.
          # (`: ${check}` does nothing at build time; referencing it makes the check a
          # build dependency.) External tools (language servers etc.) are not bundled;
          # they come from PATH, e.g. a project's dev shell via envrc.
          default = pkgs.symlinkJoin {
            name = "lupl-emacs-${pkgs.emacs.version}";
            paths = [ emacs ];
            postBuild = ": ${check}";
            meta.mainProgram = "emacs";
          };

          # Emacs bundled with this config, for trying it without touching ~/.emacs.d.
          # State (history, bookmarks, custom.el, ...) goes to ~/.local/state/lupl-emacs.
          with-config = pkgs.writeShellScriptBin "lupl-emacs" ''
            state="''${XDG_STATE_HOME:-$HOME/.local/state}/lupl-emacs"
            ${pkgs.coreutils}/bin/mkdir -p "$state"
            for f in ${self}/*; do
              ${pkgs.coreutils}/bin/ln -sfn "$f" "$state/''${f##*/}"
            done
            exec ${self.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/emacs \
              --init-directory "$state" "$@"
          '';
        });

      apps = forAllSystems (pkgs: {
        default = {
          type = "app";
          program = "${self.packages.${pkgs.stdenv.hostPlatform.system}.with-config}/bin/lupl-emacs";
        };
      });

      checks = forAllSystems (pkgs: {
        default = checkFor pkgs (emacsFor pkgs);
      });
    };
}
