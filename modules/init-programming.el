;;; init-programming.el --- Programming completion -*- lexical-binding: t; -*-

(use-package corfu
  :init
  (global-corfu-mode 1)
  (corfu-popupinfo-mode 1)
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.15)
  (corfu-auto-prefix 2)
  (corfu-cycle t)
  (corfu-preview-current nil)
  (corfu-quit-no-match 'separator)
  :bind
  (:map corfu-map
        ("M-j" . corfu-next)
        ("M-k" . corfu-previous)
        ("TAB" . corfu-insert)
        ([tab] . corfu-insert)
        ("RET" . corfu-insert)))

(use-package cape
  :init
  ;; Add useful non-LSP completion sources.
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)

  ;; make dabbrev a bit less noisy.
  (setq cape-dabbrev-min-length 2))

(provide 'init-programming)
;;; init-programming.el ends here



