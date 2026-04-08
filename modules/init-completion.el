;;; init-completion.el --- Minibuffer completion -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package vertico
  :init
  (vertico-mode 1)
  :custom
  (vertico-cycle t)
  (vertico-resize t)
  (vertico-count 20)
  :bind
  (:map vertico-map
        ("M-j" . vertico-next)
        ("M-k" . vertico-previous)))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles basic partial-completion)))))

(use-package marginalia
  :init
  (marginalia-mode 1))

(use-package consult
  :bind
  (;; search
   ("C-s"   . consult-line)
   ("C-c g" . consult-ripgrep)

   ;; buffers
   ("C-x b" . consult-buffer)
   ("C-x 4 b" . consult-buffer-other-window)

   ;; history
   ("M-y"   . consult-yank-pop)

   ;; navigation
   ("C-c i" . consult-imenu)
   ("C-c m" . consult-mark)
   ("C-c k" . consult-keep-lines)
   ("C-c u" . consult-focus-lines)))

(provide 'init-completion)
;;; init-completion.el ends here


