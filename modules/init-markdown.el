;;; init-markdown.el --- Markdown setup -*- lexical-binding: t; -*-

;;; Commentary:

;; The `markdown' and `markdown-inline' tree-sitter grammars come
;; from Nix, see flake.nix's extraEmacsPackages, via
;; treesit-grammars.with-grammars.

;;; Code:

(use-package markdown-ts-mode
  :ensure nil
  :mode (("\\.md\\'" . markdown-ts-mode)
         ("\\.markdown\\'" . markdown-ts-mode)))

(use-package markdown-ts-appear
  :ensure t
  :hook (markdown-ts-mode . markdown-ts-appear-mode))

(provide 'init-markdown)

;;; init-markdown.el ends here
