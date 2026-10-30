;;; init-nix.el --- Settings for Nix -*- lexical-binding: t; -*-

;;; Commentary:

;; The `nix' tree-sitter grammar comes from Nix (see flake.nix's
;; extraEmacsPackages, via treesit-grammars.with-grammars), not from
;; `treesit-install-language-grammar'.
;;
;; nix-ts-mode registers nix-mode as an extra parent via
;; `derived-mode-add-parents', so `provided-mode-derived-p' (which
;; eglot's server lookup uses) treats the two as compatible; but mode
;; hooks are NOT covered by that mechanism, since nix-ts-mode's real
;; `define-derived-mode' parent is prog-mode, not nix-mode. So
;; eglot-ensure is hooked onto nix-ts-mode explicitly in init-lsp.el,
;; rather than relying on the old nix-mode hook.

;;; Code:

(use-package nix-ts-mode
  :ensure t
  :mode "\\.nix\\'")

(provide 'init-nix)

;;; init-nix.el ends here
