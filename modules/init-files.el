;;; init-files.el --- File manager setup -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package ranger
  :commands (ranger deer deer-find-file)
  :init
  (setq ranger-cleanup-eagerly t
        ranger-show-hidden t
        ranger-preview-file t)
  (ranger-override-dired-mode t)
  :config
  (defun get-buffers-by-mode (&rest modes)
    "Get all buffers with mode MODES."
    (cl-remove-if-not
     #'(lambda (buffer)
         (with-current-buffer buffer
           (when (member major-mode modes)
             buffer)))
     (buffer-list)))
  
  (defun ranger-kill-all ()
    (interactive)
    (let ((kill-list (list 'dired-mode 'ranger-mode)))
      (when (member major-mode kill-list)
        (delete-other-windows)
        (mapc #'kill-buffer
              (apply #'get-buffers-by-mode kill-list)))))
  :bind
  (:map ranger-mode-map
        ("q" . ranger-kill-all)))

(defun lupl/ranger-force-emacs-state ()
  "Force Emacs state in ranger/deer buffers."
  (let ((buf (current-buffer)))
    (run-at-time
     0 nil
     (lambda ()
       (when (buffer-live-p buf)
         (with-current-buffer buf
           (when (derived-mode-p 'ranger-mode 'dired-mode)
             (evil-emacs-state))))))))

(add-hook 'ranger-mode-hook #'lupl/ranger-force-emacs-state)
(add-hook 'dired-mode-hook  #'lupl/ranger-force-emacs-state)

(provide 'init-files)

;;; init-files.el ends here
