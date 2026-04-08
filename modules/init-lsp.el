;;; init-lsp.el --- LSP support -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package eglot
  :ensure nil
  :commands (eglot eglot-ensure)
  :hook
  ((python-mode . eglot-ensure)
   (nix-mode . eglot-ensure))
  :config
  ;; (add-to-list 'eglot-server-programs
  ;;              '(nix-mode . ("nil")))
  ;; (add-to-list 'eglot-server-programs
  ;;              '((python-mode python-mode) . ("ty" "server")))
  (add-to-list 'eglot-server-programs
               '((python-mode python-ts-mode)
                 "basedpyright-langserver" "--stdio"))
  (add-to-list 'eglot-server-programs
               '(nix-mode . ("nixd"))))

(provide 'init-lsp)

;;; init-lsp.el ends here
