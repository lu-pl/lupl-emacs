;;; init-zoom.el --- Settings for global zooming. -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package face-remap
  :demand t
  :bind (("C-M-=" . global-text-scale-adjust)
         ("C-M--" . global-text-scale-adjust)
         ("C-M-0" . global-text-scale-adjust))
  :config
  ;; Lock in the baseline height set in init.el, so zooming always
  ;; returns to the configured default rather than whatever height
  ;; happened to be active the first time the command was invoked.
  (setq global-text-scale-adjust--default-height
        (face-attribute 'default :height)))


(provide 'init-zoom)
;;; init-zoom.el ends here
