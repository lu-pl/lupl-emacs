;;; init-prolog.el --- SWI-Prolog setup -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package sweeprolog
  :mode (("\\.pl\\'"  . sweeprolog-mode)
         ("\\.pro\\'" . sweeprolog-mode))
  :interpreter ("swipl" . sweeprolog-mode))

(provide 'init-prolog)

;;; init-prolog.el ends here
