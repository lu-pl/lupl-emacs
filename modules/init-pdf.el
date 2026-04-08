;;; init-pdf.el --- PDF support -*- lexical-binding: t; -*-

(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  ;; Install epdfinfo server if needed
  (pdf-tools-install)

  (setq-default pdf-view-display-size 'fit-page)
  ;; Smooth scrolling
  (setq pdf-view-use-scaling t
        pdf-view-use-imagemagick nil)

  ;; Dark mode support
  (add-hook 'pdf-view-mode-hook #'pdf-view-midnight-minor-mode)

  ;; Faster rendering
  (setq pdf-cache-image-limit 50))

(provide 'init-pdf)
