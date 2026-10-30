;;; init-pilish.el --- Pi coding agent frontend -*- lexical-binding: t; -*-

;;; Commentary:

;; Pilish runs the `pi' CLI (from NixOS, see ~/nixos/modules/shell.nix)
;; in RPC mode.  Its tree-sitter grammars come from Nix, see flake.nix's
;; extraEmacsPackages, so decline the offer to install them.
;; Log in once with plain `pi' in a terminal and `/login'.

;;; Code:

(use-package pilish
  :ensure t
  :commands (pilish pilish-toggle)
  :init
  (defalias 'pi 'pilish)
  :config
  (pilish-evil-setup))

(provide 'init-pilish)

;;; init-pilish.el ends here
