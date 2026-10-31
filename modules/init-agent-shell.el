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
  (setq agent-shell-preferred-agent-config 'claude-code))

(provide 'init-agent-shell)

;;; init-agent-shell.el ends here
