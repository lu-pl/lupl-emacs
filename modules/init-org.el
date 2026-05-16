;;; init-org.el --- Org setup -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package org
  :ensure nil
  :hook
  ((org-mode . org-indent-mode)
   (org-capture-mode . evil-emacs-state))
  :bind
  (("C-c c" . org-capture)
   ("C-c a" . org-agenda))
  :custom
  ;; general
  (org-pretty-entities t)
  (org-hide-emphasis-markers t)
  (org-image-actual-width 800)
  (org-startup-with-inline-images t)

  ;; TODO workflow
  (org-todo-keywords
   '((sequence "NEXT(n!)" "TODO(t!)" "POSTPONE(p@/!)" "|"
               "DONE(d!)" "CANCELLED(c!)")))
  (org-log-into-drawer "LOGBOOK")
  (org-log-reschedule 'time)

  ;; files
  (org-agenda-files
   (list (expand-file-name "~/log.org")))

  ;; capture
  (org-capture-templates
   '(("t" "Tasks")
     ("tt" "prolog todo" entry
      (file+olp+datetree "~/log.org")
      "* TODO %?\n%U"
      :time-prompt t
      :empty-lines-before 0
      :empty-lines 1)
     ("tp" "prolog pending" entry
      (file+headline "~/log.org" "pending")
      "**** TODO %?"
      :prepend t)
     ("f" "fleeting note" entry
      (file+headline "~/zettelkasten/fleeting.org" "Notes")
      "* %?\n%U"
      :prepend t
      :empty-lines 1)))

  ;; babel
  (org-confirm-babel-evaluate nil)
  
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (shell . t)
     (prolog . t)
     (emacs-lisp . t))))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :config
  (setq org-bullets-bullet-list
	'("◉" "•" "►" ">" "→")))

(provide 'init-org)

;;; init-org.el ends here
