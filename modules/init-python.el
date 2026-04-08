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

(defun lupl/python-ruff-fix-and-format ()
  (when (and
         (derived-mode-p 'python-mode)
         (buffer-file-name)
         (executable-find "ruff"))
    (let ((file (buffer-file-name)))
      (call-process "ruff" nil "*Ruff*" nil "check" "--select" "I" "--fix" file)
      (call-process "ruff" nil "*Ruff*" nil "format" file)
      (revert-buffer :ignore-auto :noconfirm))))

(add-hook 'python-mode-hook
          (lambda ()
            (add-hook 'after-save-hook
                      #'lupl/python-ruff-fix-and-format
                      nil t)))

(provide 'init-python)

;;; init-python.el ends here
