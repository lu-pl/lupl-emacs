;;; init-ui.el --- UI helpers -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package eldoc-box
  :hook
  (prog-mode . eldoc-box-hover-mode)
  :custom
  (eldoc-box-hover-delay 0.3))

(provide 'init-ui)

;;; init-ui.el ends here
