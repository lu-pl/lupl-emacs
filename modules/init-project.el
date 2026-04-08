;;; init-project.el --- Project support -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package project
  :ensure nil
  :bind (("C-x p f" . project-find-file)
         ("C-x p b" . project-switch-to-buffer)
         ("C-x p g" . project-find-regexp)
         ("C-x p p" . project-switch-project)
         ("C-x p d" . project-dired)))

(provide 'init-project)

;;; init-project.el ends here
