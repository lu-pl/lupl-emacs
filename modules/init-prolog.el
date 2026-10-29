;;; init-prolog.el --- SWI-Prolog setup -*- lexical-binding: t; -*-

;;; Commentary:
;; lupl/sweeprolog-use-current-swipl ensures that envrc-mode is on
;; before Sweep looks for the Swipl path; this allows project-local +
;; Nix shell based development.

;;; Code:

(defun lupl/sweeprolog-use-current-swipl (&rest _)
  "Initialize Sweep with the swipl provided by the current envrc."
  (unless (featurep 'sweep-module)
    (envrc-mode 1) ; ensure envrc-mode is on

    (setq sweeprolog-swipl-path
          (or (executable-find "swipl")
              (user-error
               "No swipl executable in the current envrc environment")))))


(use-package sweeprolog
  :mode (("\\.pl\\'"  . sweeprolog-mode)
         ("\\.pro\\'" . sweeprolog-mode))
  :interpreter ("swipl" . sweeprolog-mode)
  :config
  (advice-add 'sweeprolog-ensure-initialized
              :before #'lupl/sweeprolog-use-current-swipl))

(provide 'init-prolog)

;;; init-prolog.el ends here
