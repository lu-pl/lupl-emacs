;;; init-pdf.el --- PDF support -*- lexical-binding: t; -*-

(use-package pdf-tools
  :ensure nil 
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (pdf-tools-install :no-query) 
  
  (setq-default pdf-view-display-size 'fit-page)
  
  ;; Smooth scrolling
  (setq pdf-view-use-scaling t
        pdf-view-use-imagemagick nil
        pdf-cache-image-limit 50)

  ;; Dark mode support
  (add-hook 'pdf-view-mode-hook #'pdf-view-midnight-minor-mode))

(provide 'init-pdf)
