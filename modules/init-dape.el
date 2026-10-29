;;; init-dape.el --- dape setup for DAP debugging -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package dape
  :ensure t
  ;; To use window configuration like gud (gdb-mi)
  ;; (setq dape-buffer-window-arrangement 'gud)
  ;; :preface
  ;; (setq dape-key-prefix "\C-x\C-a") ; optional, default is fine too
  
  :hook
  ;; Save breakpoints on kill and restore on start
  ((kill-emacs . dape-breakpoint-save)
   (dape-on-start . dape-breakpoint-load))
  :custom
  ;; Don't automatically show/kill the REPL and info buffers
  (dape-buffer-window-arrangement 'right)
  ;; Info buffers to auto-open when stopped (locals + breakpoints, no hydra needed)
  (dape-info-hide-mode-line nil)
  ;; Turn off if you find it noisy; on by default and genuinely useful
  (dape-inlay-hints t)
  )

(provide 'init-dape)

;;; init-dape.el ends here
