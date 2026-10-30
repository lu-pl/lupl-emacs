;;; init.el --- Emacs init -*- lexical-binding: t; -*-

;;; Commentary:
;; Core settings, package bootstrap, and module loading.
;; Hic sunt draconis.

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; identity
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq user-full-name "Lukas Plank"
      user-mail-address "lupl@tuta.io")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; general settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq calendar-week-start-day 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; startup / performance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq gc-cons-threshold most-positive-fixnum
      large-file-warning-threshold 100000000)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 32 1024 1024))))

(setq package-native-compile t)

;; Async native-compilation of newly-installed packages can warn about
;; functions that don't exist on this Emacs/library version (harmless
;; when the affected code path is never actually called); log instead
;; of popping up the *Warnings* buffer every time.
(setq native-comp-async-report-warnings-errors 'silent)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; paths
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'exec-path (expand-file-name "~/.local/bin/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; UI / behaviour
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(blink-cursor-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

(electric-pair-mode 1)

(global-visual-line-mode 1)
(global-prettify-symbols-mode 1)
(global-auto-revert-mode 1)
(show-paren-mode 1)
(winner-mode 1)
(display-time-mode 1)
(display-battery-mode 1)

(setq display-time-24hr-format t
      inhibit-startup-message t
      initial-scratch-message ""
      ring-bell-function #'ignore
      scroll-conservatively 100
      show-paren-style 'expression)

(setq-default fill-column 100)

(set-face-attribute 'default nil
                    ;; :family "Source Code Pro" 
                    :height 110)

(setq history-length 25)
(savehist-mode 1)

(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; editing defaults
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-subword-mode 1)

(setq eval-expression-print-length nil
      eval-expression-print-level nil)

(setq-default indent-tabs-mode nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; persistence / files
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(save-place-mode 1)
(recentf-mode 1)

(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups/" user-emacs-directory))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; prompts / generated files
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq use-short-answers t)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file nil t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; package management
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)

(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; When Emacs is built by Nix (see flake.nix), every use-package package is
;; provided by the Nix build, so use-package must never install from ELPA:
;; a package missing there is a gap in the Nix build and should fail loudly.
;; `M-x try' and `M-x package-install' still work for trying things out.
(defvar lupl/nix-missing-packages nil
  "Packages use-package wanted that the Nix build doesn't provide.")

(defun lupl/use-package-ensure-nix (name args _state &optional _no-refresh)
  "Like `use-package-ensure-elpa', but signal an error instead of installing."
  (dolist (ensure args)
    (let ((package (or (and (eq ensure t) (use-package-as-symbol name))
                       ensure)))
      (when (consp package)
        (setq package (car package)))
      (when (and package (not (package-installed-p package)))
        (push package lupl/nix-missing-packages)
        (error "Package `%s' is not provided by the Nix build; rebuild the flake" package)))))

(when (string-prefix-p "/nix/store/" invocation-directory)
  (setq use-package-ensure-function #'lupl/use-package-ensure-nix))

(use-package try
  :commands try)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; module loading
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

(require 'init-evil)
(require 'init-theme)
(require 'init-files)
(require 'init-keys)
(require 'init-completion)
(require 'init-programming)
(require 'init-lsp)
(require 'init-ui)
(require 'init-vterm)
(require 'init-python)
(require 'init-prolog)
(require 'init-bookmarks)
(require 'init-snippets)
(require 'init-cl)
(require 'init-nix)
(require 'init-org)
(require 'init-embark)
(require 'init-magit)
(require 'init-sparql)
(require 'init-latex)
(require 'init-nyan)
(require 'init-envrc)
(require 'functions)
(require 'init-folding)
(require 'init-ttl)
(require 'init-zoom)
(require 'init-pdf)
(require 'init-project)
(require 'init-server)
(require 'init-vundo)
(require 'init-which-key)
(require 'init-dape)
(require 'init-rdf-prefix)
(require 'init-markdown)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; local quirks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-unset-key (kbd "<f20>"))

(provide 'init)
;;; init.el ends here
