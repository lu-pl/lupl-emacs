# LUPL Emacs config

<img src="assets/github-emblem.svg" width="400">

Emacs config built as a Nix flake: every package declared with `use-package` is
provided by Nix (via [emacs-overlay](https://github.com/nix-community/emacs-overlay)'s
`emacsWithPackagesFromUsePackage`), pinned in `flake.lock`.

## Try it

Requires Nix with flakes enabled. Runs Emacs with this config without touching
`~/.emacs.d`; state (history, bookmarks, `custom.el`, ...) goes to
`~/.local/state/lupl-emacs`.

```sh
nix run github:lu-pl/lupl-emacs
```

## Outputs

- `packages.default`: Emacs with all packages; reads the config from
  `~/.emacs.d` as usual. Only builds if the config loads cleanly (see below).
- `packages.with-config` / `apps.default`: the same Emacs bundled with this config.
- `checks.default`: loads the whole config in batch mode and fails if any
  `use-package` package isn't provided by the Nix build.

## Strict packages

When running from `/nix/store`, use-package never installs from ELPA; a missing
package is an error (see `lupl/use-package-ensure-nix` in `init.el`). Use
`M-x try` to try a package without adding it to the config.

After adding or removing a `use-package` form, commit and rebuild:

```sh
nix flake check          # or, from the NixOS config:
nix flake update lupl-emacs && nixos-rebuild switch --flake ~/nixos --sudo
```

Update all packages with `nix flake update`.
