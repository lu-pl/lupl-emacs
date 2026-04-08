;;; init-vterm.el --- Terminal setup -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package vterm
  :ensure nil
  :commands (vterm)
  :hook
  (vterm-mode . (lambda ()
                  (display-line-numbers-mode -1)
                  (hl-line-mode -1)))
  :init
  (setq vterm-shell (or (executable-find "zsh")
                        (executable-find "bash")
                        shell-file-name))
  :config
  ;; Let Emacs handle these keys instead of sending them to the terminal.
  (dolist (key '("M-r" "M-d"))
    (define-key vterm-mode-map (kbd key) nil)
    (add-to-list 'vterm-keymap-exceptions key))
  :bind
  ("M-<return>" . vterm))

(provide 'init-vterm)

;;; init-vterm.el ends here
