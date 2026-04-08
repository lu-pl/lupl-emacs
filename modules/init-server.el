;;; init-server.el --- Start Emacs server -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(require 'server)

(unless (server-running-p)
  (server-start))

(provide 'init-server)

;;; init-server.el ends here
