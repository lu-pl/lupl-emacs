;;; init-bookmarks.el --- Bookmark setup -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package bookmark
  :ensure nil
  :bind (("C-x r b" . consult-bookmark))
  :custom
  (bookmark-default-file (expand-file-name "bookmarks" user-emacs-directory))
  (bookmark-save-flag 1))

(provide 'init-bookmarks)

;;; init-bookmarks.el ends here
