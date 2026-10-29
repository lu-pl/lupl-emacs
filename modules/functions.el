;;; functions.el --- Custom functions for LUPL Emacs. -*- lexical-binding: t; -*-

;;; Commentary:



;;; Code:

(defun lupl/load-theme (theme)
  "Disable all enabled themes, then load THEME."
  (interactive
   (list
    (intern (completing-read
             "Load custom theme: "
             (mapcar #'symbol-name
                     (custom-available-themes))))))
  (mapc #'disable-theme custom-enabled-themes)
  (load-theme theme t))


(provide 'functions)

;;; functions.el ends here
