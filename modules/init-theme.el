;;; init-theme.el --- Theme setup -*- lexical-binding: t; -*-

(use-package darkmine-theme
  :config
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme 'darkmine t)
  
  ;; --- overrides ---
  (custom-set-faces
   '(region ((t (:background "dark green" :foreground "#FFFFFF"))))
   '(show-paren-match ((t (:background "gray15"))))
   '(org-level-4 ((t (:foreground "#d15263"))))
   '(org-headline-done ((t (:foreground "gray"))))))
  

(provide 'init-theme)
