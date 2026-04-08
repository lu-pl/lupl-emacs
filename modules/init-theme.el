;;; init-theme.el --- Theme setup -*- lexical-binding: t; -*-

(use-package darkmine-theme
  :config
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme 'darkmine t)
    ;; --- overrides ---
  (set-face-attribute 'region nil
                      :background "dark green"
                      :foreground "#FFFFFF")
  (set-face-attribute 'show-paren-match nil
                      :background "#3e3e40"))

(provide 'init-theme)
