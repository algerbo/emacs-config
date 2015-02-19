;;; From MELPA: smex

;;; http://wikemacs.org/wiki/Smex

;;(require 'smex)   ;; Not needed if you use package.el
(smex-initialize)

;;; Автообновление кэша после 3мин. простоя Emacs ;-)
(setq smex-auto-update t)
(smex-auto-update 180)

;;; Не засорять ненужным хламом ;-)
(setq smex-history-length 0)
(setq smex-save-file (concat (getenv "HOME") "/.emacs.d/.smex-items"))

(setq smex-prompt-string "smex -> ")
(setq smex-show-unbound-commands t)
(setq smex-flex-matching t)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x C-m") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c M-x") 'smex-update)
;;; Старый вариант для 'M-x'
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;;
(provide '02-smex-setup)
;;; END here
