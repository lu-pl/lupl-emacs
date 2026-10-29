;;; init-folding.el --- Code folding setup -*- lexical-binding: t; -*-

;;; Commentary:

;; Code folding setup with Kirigami and Evil bindings.

;;; Code:

(use-package kirigami
  :ensure t
  :custom
  (kirigami-show-menu-bar nil)
  (kirigami-show-context-menu nil)
  :init
  (kirigami-global-mode 1)
  :config
  (with-eval-after-load 'evil
    (define-key evil-normal-state-map "zo" #'kirigami-open-fold)
    (define-key evil-normal-state-map "zO" #'kirigami-open-fold-rec)
    (define-key evil-normal-state-map "zc" #'kirigami-close-fold)
    (define-key evil-normal-state-map "za" #'kirigami-toggle-fold)
    (define-key evil-normal-state-map "zr" #'kirigami-open-folds)
    (define-key evil-normal-state-map "zm" #'kirigami-close-folds)))

(provide 'init-folding)

;;; init-folding.el ends here

