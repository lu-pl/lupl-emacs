;;; init-snippets.el --- Snippet setup -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package yasnippet
  :init
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :after yasnippet)


(provide 'init-snippets)

;;; init-snippets.el ends here

