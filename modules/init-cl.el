;;; init-cl.el --- Setup for CL programming -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package sly
  :ensure t
  :commands (sly sly-connect)
  :init
  (setq inferior-lisp-program "sbcl")
  :config
  ;; fix REPL <return> for insert and emacs state
  (with-eval-after-load 'sly-mrepl
    (evil-define-key '(insert emacs) sly-mrepl-mode-map
      (kbd "RET") #'sly-mrepl-return)))

(use-package lisp-mode
  :ensure nil
  :hook ((lisp-mode . lupl/lisp-mode-setup))
  :config
  (defun lupl/lisp-mode-setup ()
    (setq-local lisp-indent-function #'common-lisp-indent-function)
    (electric-pair-local-mode 1)
    (show-paren-local-mode 1)
    (display-line-numbers-mode 1)))

(use-package rainbow-delimiters
  :ensure t
  :hook (lisp-mode . rainbow-delimiters-mode))

(use-package paredit
  :ensure t
  :hook ((lisp-mode sly-mrepl-mode) . paredit-mode))


(provide 'init-cl)
;;; init-cli.el ends here

