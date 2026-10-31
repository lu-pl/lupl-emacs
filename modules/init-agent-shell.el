;;; init-agent-shell.el --- Claude Code in a comint buffer -*- lexical-binding: t; -*-

;;; Commentary:

;; agent-shell talks ACP to the `claude-agent-acp' adapter (from NixOS,
;; see ~/nixos/modules/shell.nix), which runs Claude Code's engine.
;; Authentication defaults to the Claude subscription login
;; (`agent-shell-anthropic-authentication' is `:login t').

;;; Code:

(use-package agent-shell
  :ensure t
  :commands (agent-shell agent-shell-toggle)
  :init
  (setq agent-shell-preferred-agent-config 'claude-code
        agent-shell-header-style 'text
        agent-shell-show-welcome-message nil)
  :config
  ;; Free M-r for the global binding (`ranger') instead of history search.
  (define-key agent-shell-mode-map (kbd "M-r") nil)
  (with-eval-after-load 'agent-shell-viewport
    (define-key agent-shell-viewport-edit-mode-map (kbd "M-r") nil))
  ;; Evil's normal state shadows the diff buffer's y/n/p/q bindings.
  (with-eval-after-load 'evil
    (evil-set-initial-state 'agent-shell-diff-mode 'emacs)))

(provide 'init-agent-shell)

;;; init-agent-shell.el ends here
