 ;;; init-embark.el --- Embark actions -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package embark
  :bind
  (("M-l" . embark-act)         ;; act on candidate or thing at point
   ("C-h B" . embark-bindings)) ;; show keybindings for current context
  :init
  ;; prefix help
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :after (embark consult)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(provide 'init-embark)

;;; init-embark.el ends here
