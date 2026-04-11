;;; init-vundo.el --- Visual undo tree -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package vundo
  :bind (("C-c u" . vundo))
  :custom
  ;; Use the nicer Unicode drawing characters.
  (vundo-glyph-alist vundo-unicode-symbols)
  ;; Keep the graph compact so it fits better in normal windows.
  (vundo-compact-display t))

;; Sensible undo history limits so vundo has more to show.
(setq undo-limit        (* 64 1024 1024)
      undo-strong-limit (* 96 1024 1024)
      undo-outer-limit  (* 960 1024 1024))

(provide 'init-vundo)

;;; init-vundo.el ends here
