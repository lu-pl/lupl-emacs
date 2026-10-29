;;; init-rdf-prefix.el --- rdf-prefix setup -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package rdf-prefix
  :ensure t
  :defines (rdf-prefix-alist rdf-prefix-history)
  :functions rdf-prefix-lookup
  :bind (("C-c p s" . lupl/sparql-prefixes)
         ("C-c p t" . lupl/turtle-prefixes))

  :preface
  (defmacro lupl/define-rdf-prefix-command (name template)
    "Define command NAME inserting TEMPLATE for each chosen prefix."
    `(defun ,name (prefixes)
       (interactive (list (lupl/rdf-read-prefixes)))
       (lupl/rdf-insert-prefixes ,template prefixes)))

  (lupl/define-rdf-prefix-command
    lupl/sparql-prefixes
    "prefix %s: <%s>\n")

  (lupl/define-rdf-prefix-command
    lupl/turtle-prefixes
    "@prefix %s: <%s> .\n")

  ;; :config
  ;; (add-to-list 'rdf-prefix-alist '("lupl" . "https://example.org/lupl#")))
  )

(provide 'init-rdf-prefix)

;;; init-rdf-prefix.el ends here

