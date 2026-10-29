;;; init-python.el --- Python setup -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun lupl/run-python ()
  "Wrapper around 'run-python' that behaves like elpy-execute."
  (interactive)
  (let ((origin-window (selected-window))
	(python-buffer (get-buffer "*Python*")))
    (when python-buffer
      (kill-buffer python-buffer))
    (call-interactively 'run-python)
    (select-window origin-window)))

(defun lupl/python-shell-send-buffer ()
  "Wrapper around python-shell-buffer that behaves like elpy-shell-send-region-or-buffer."
  (interactive)
  (if (python-shell-get-process)
      (python-shell-send-buffer)
    (lupl/run-python)))

(use-package python
  :ensure nil
  :mode ("\\.py\\'" . python-mode)
  :custom
  (python-shell-interpreter "python3")
  :bind
  (:map python-mode-map
   (("C-c C-c" . lupl/python-shell-send-buffer)
   ("C-c e" . lupl/run-python))))

(use-package pyvenv
  :config
  (pyvenv-mode 1))

;; `ruff-format' only covers `ruff format'; define a matching
;; reformatter for the import-sorting fixes the old hand-rolled
;; version also applied, so both run via `replace-buffer-contents'
;; (preserving undo history and point) instead of `call-process' +
;; `revert-buffer', which discards the buffer's undo list on every
;; save.
(require 'reformatter)

(reformatter-define ruff-fix-imports
  :program "ruff"
  :args (list "check" "--select" "I" "--fix" "--stdin-filename"
              (or (buffer-file-name) input-file))
  :lighter " RuffFix"
  :group 'ruff-format)

(use-package ruff-format
  :ensure t
  :commands (ruff-format-buffer ruff-format-on-save-mode))

;; Live lint diagnostics from ruff via flymake, independent of and
;; alongside eglot's pyright type-check diagnostics (eglot-ensure
;; already turns on flymake-mode for managed buffers).
;;
;; TODO: Eglot's devel branch (1.24.0, GNU-devel ELPA) adds real
;; multi-server support via the Rassumfrassum ("rass") LSP
;; multiplexer, which would let a single eglot connection combine
;; pyright + ruff directly and make this separate flymake backend
;; unnecessary. Not worth it yet: it requires bumping eldoc,
;; flymake, jsonrpc, and project off the versions bundled with this
;; Emacs, onto unreleased devel-channel snapshots (flymake and
;; jsonrpc as of this writing are only ~2 weeks old), and eglot.el
;; itself documents a known upgrade-mechanism bug in this area
;; (Emacs bug#62576). Revisit once multi-server support ships in a
;; stable Emacs/Eglot release, then drop flymake-ruff below and wire
;; up rass in init-lsp.el's eglot-server-programs instead.
(use-package flymake-ruff
  :ensure t
  :hook (python-mode . flymake-ruff-load))

(defun lupl/python-ruff-fix-and-format ()
  "Fix import sorting, then format the buffer, via ruff.
Runs quietly on failure (e.g. ruff not on PATH) rather than
erroring, matching `ruff-format-on-save-mode' behavior."
  (ruff-fix-imports-buffer)
  (ruff-format-buffer))

(add-hook 'python-mode-hook
          (lambda ()
            (add-hook 'before-save-hook
                      #'lupl/python-ruff-fix-and-format
                      nil t)))

(provide 'init-python)

;;; init-python.el ends here
