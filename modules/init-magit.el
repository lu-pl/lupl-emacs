;;; init-magit.el --- Magit setup -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status))
  :custom
  ;; refine diffs for better readability
  (magit-diff-refine-hunk t)
  :config
  (setq magit-log-section-commit-count 50))

(provide 'init-magit)

;;; init-magit.el ends here
