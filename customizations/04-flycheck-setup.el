;;; From MELPA

;;; http://flycheck.readthedocs.org/

;;; Описание статусов:
;;;Flycheck indicates its state in the mode line:
;;FlyC
;;    There are no errors in the current buffer.
;;FlyC*
;;    A syntax check is being performed currently.
;;FlyC:3/4
;;    There are 3 errors and 4 warnings in the current buffer.
;;FlyC-
;;    Automatic syntax checker selection did not find a suitable syntax checker.
;;    See Syntax checker selection for more information.
;;FlyC!
;;    The syntax check failed. Inspect the *Messages* buffer for details.
;;FlyC?
;;    The syntax check had a dubious result.
;;    The definition of the syntax checker may be flawed.
;;    Inspect the *Messages* buffer for details.

;;; Основные настройки

(require 'flycheck)

;;; Отключаем некоторые проверки
(eval-after-load 'flycheck
  '(setq flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers)))

;;; UNCOMPLETED: надо потестировать этот параметр
;;; по умолчанию nil
;;; для 'ido' необходимо активировать ido
;;; и установить пакет MELPA: flx
(setq flycheck-completion-system (quote ido))

;;; UNCOMPLETED: надо потестировать этот параметр
;;; по умолчанию symbols
(setq flycheck-highlighting-mode (quote sexps))

(setq flycheck-indication-mode (quote left-fringe))
(setq flycheck-display-errors-delay 0.5)

;;; Активируем flycheck глобально ;)
(add-hook 'after-init-hook #'global-flycheck-mode)

;;; Дополнительный пакет MELPA: flycheck-color-line-mode
;;; подсветка режима FlyCh в status line

(require 'flycheck-color-mode-line)
(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

;;;
(provide '04-flycheck-setup)
;;; END here
