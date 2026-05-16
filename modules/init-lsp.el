;;; init-lsp.el --- LSP support -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package eglot
  :ensure nil
  :commands (eglot eglot-ensure)
  :hook
  ((python-mode . eglot-ensure)
   (nix-mode . eglot-ensure)
   (sparql-mode . eglot-ensure))
  :config
  ;; (add-to-list 'eglot-server-programs
  ;;              '((python-mode python-ts-mode) . ("ty" "server")))
  (add-to-list 'eglot-server-programs
               '((python-mode python-ts-mode)
                 "basedpyright-langserver" "--stdio"))
  (add-to-list 'eglot-server-programs
               '(nix-mode . ("nixd")))
  (add-to-list 'eglot-server-programs
               '(sparql-mode . ("qlue-ls" "server"))))

(provide 'init-lsp)

;;; init-lsp.el ends here
