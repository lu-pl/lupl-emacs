;;; init-lsp.el --- LSP support -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package eglot
  :ensure nil
  :commands (eglot eglot-ensure)
  :hook
  ((python-mode nix-mode sparql-mode ttl-mode) . eglot-ensure)
  :config
  (setq eglot-server-programs
        (append
         '(((python-mode python-ts-mode)
            "pyright-langserver" "--stdio")
           (nix-mode "nixd")
           (sparql-mode "qlue-ls" "server")
           ((ttl-mode :language-id "turtle") "swls"))
         eglot-server-programs)))

(provide 'init-lsp)

;;; init-lsp.el ends here
