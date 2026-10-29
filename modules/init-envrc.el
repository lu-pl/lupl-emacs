;;; init-envrc.el --- envrc setup -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package envrc
  :ensure t
  :hook (after-init . envrc-global-mode)
  :config
  (setq envrc-show-summary-in-minibuffer nil))


(provide 'init-envrc)

;;; init-envrc.el ends here
