;;; init-nix.el --- Settings for Nix -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'"
  :hook (nix-mode . eglot-ensure))

(provide 'init-nix)

;;; init-nix.el ends here
