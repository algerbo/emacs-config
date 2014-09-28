;;; From MELPA

;;; Основные настройки

(require 'auto-complete)
(require 'auto-complete-config)
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")

(ac-config-default)
(global-auto-complete-mode t)

;;; Необходимый фикс для flyspell
;;; http://www.emacswiki.org/emacs/AutoComplete
;;; http://cx4a.org/software/auto-complete/manual.html (SEE: 11. Known Bugs)
;;; FIX: Auto completion will not be started in a buffer flyspell-mode enabled
(ac-flyspell-workaround)

;;; Лекарство. ;)
;;; Если иногда сбоит автокомплит
(define-globalized-minor-mode
  real-global-auto-complete-mode
  auto-complete-mode
  (lambda ()
    (if (not (minibufferp (current-buffer)))
        (auto-complete-mode 1))))

(real-global-auto-complete-mode t)

;;; не сорим $HOME/.emacs.d/
(setq ac-use-comphist t)
(setq ac-comphist-file "/tmp/ac-comphist.dat")

(setq ac-auto-show-menu 0.5)
(setq ac-use-quick-help t)
(setq ac-quick-help-delay 1.0)
(setq ac-quick-help-height 30)
(setq ac-show-menu-immediately-on-auto-complete t)
(setq ac-expand-on-auto-complete t)
(setq ac-auto-start 1)

(setq ac-dwim t)
(setq ac-dwim-enable t)

(setq ac-use-fuzzy t)

;;; Попытаться оптимизировать список дополнений
;;; Если список отображается коряво, то установить в nil.
(setq popup-use-optimized-column-computation t)

;;; работает при ac-auto-start = nil
;;(ac-set-trigger-key "TAB")
;;;;(ac-set-trigger-key "<tab>")

;;;
(provide '02-autocomplete-setup)
;;; END here
