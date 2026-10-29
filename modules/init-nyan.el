;;; init-nyan.el --- nyan-mode -*- lexical-binding: t; -*-

;;; Commentary:
;;; Code:

(use-package nyan-mode
  :ensure t
  :config
  (nyan-mode 1)

  (setq nyan-bar-length 16
        nyan-animate-nyancat t
        nyan-wavy-trail nil))


(provide 'init-nyan)
;;; init-nyan.el ends here
