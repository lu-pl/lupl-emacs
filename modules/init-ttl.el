;;; init-ttl.el --- description -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun lupl/ttl-setup ()
  "Disable Turtle indentation and enable SWLS formatting on save."
  (electric-indent-local-mode -1)
  (add-hook 'before-save-hook #'eglot-format-buffer nil t))

(use-package ttl-mode
  :ensure t
  :mode ("\\.ttl\\'" . ttl-mode)
  :custom
  (ttl-electric-punctuation nil)
  :hook
  ((ttl-mode . eglot-ensure)
   (ttl-mode . lupl/ttl-setup)))

(provide 'init-ttl)

;;; init-ttl.el ends here
