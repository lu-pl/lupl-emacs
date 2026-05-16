;;; init-latex.el --- LaTeX support -*- lexical-binding: t; -*-

(use-package tex
  :ensure nil
  :defer t
  :mode ("\\.tex\\'" . LaTeX-mode)
  :hook
  ((LaTeX-mode . LaTeX-math-mode)
   (LaTeX-mode . TeX-source-correlate-mode)
   (LaTeX-mode . TeX-fold-mode))
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-master nil)
  (TeX-PDF-mode t)
  (TeX-save-query nil)
  (TeX-source-correlate-method 'synctex)
  (TeX-source-correlate-start-server t)
  (TeX-view-program-selection '((output-pdf "PDF Tools")))
  (TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view)))
  :config
  (add-to-list
   'TeX-command-list
   '("LatexMk"
     "latexmk -pdf -synctex=1 -interaction=nonstopmode -file-line-error %s"
     TeX-run-TeX nil t
     :help "Run latexmk"))

  (setq TeX-command-default "LatexMk"))

(provide 'init-latex)
