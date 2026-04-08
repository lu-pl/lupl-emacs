;;; init-magit.el --- Magit setup -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
  :custom
  ;; refine diffs for better readability
  (magit-diff-refine-hunk t))

(provide 'init-magit)

;;; init-magit.el ends here
