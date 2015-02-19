;;; PROLOG:

(require 'prolog)

;;; используем swi-prolog ;)

(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
;;; !!! export EPROLOG=/path/to/swipl/binary
(setq-default prolog-system 'swi
              prolog-program-switches
              '((swi ("-G128M" "-T128M" "-L128M" "-O"))
                (t nil)))

(setq prolog-inferior (concat (getenv "HOME") "/0PROLOG/bin/swipl"))
(setq prolog-program-name (concat (getenv "HOME") "/0PROLOG/bin/swipl"))

(setq auto-mode-alist
      (append
       '(("\\.pl$"     . prolog-mode) ;; FIXME: конфликт с Perl?
         ("\\.prl$"    . prolog-mode)
         ("\\.prolog$" . prolog-mode)
         ("\\.swi$"    . prolog-mode))
       auto-mode-alist))

;;; ширина отступов ...
(setq prolog-indent-width 2)
(setq prolog-paren-indent-p t)
(setq prolog-paren-indent 2)

;;; удалить все пробелы... FIX: set it to 'nil' ?
(setq prolog-hungry-delete-key-flag t)

;;; автоматическое форматирование:
(setq prolog-electric-dot-flag t)
(setq prolog-electric-dot-full-predicate-template t)
(setq prolog-electric-underscore-flag t)
(setq prolog-electric-if-then-else-flag t)
(setq prolog-electric-colon-flag t)
(setq prolog-electric-dash-flag t)

;; insert in your Prolog files the following comment as the first line:
;;  % -*- Mode: Prolog -*-

;;   "Define keybindings common to both Prolog modes in MAP."
;;   "\C-c?" 'prolog-help-on-predicate
;;   "\C-c/" 'prolog-help-apropos
;;   "\C-c\C-d" 'prolog-debug-on
;;   "\C-c\C-t" 'prolog-trace-on
;;   "\C-c\C-z" 'prolog-zip-on
;;   "\C-c\r" 'run-prolog

;;   "Define keybindings for Prolog mode in MAP."
;;   "\M-a" 'prolog-beginning-of-clause
;;   "\M-e" 'prolog-end-of-clause
;;   "\M-q" 'prolog-fill-paragraph
;;   "\C-c\C-a" 'align
;;   "\C-\M-a" 'prolog-beginning-of-predicate
;;   "\C-\M-e" 'prolog-end-of-predicate
;;   "\M-\C-c" 'prolog-mark-clause
;;   "\M-\C-h" 'prolog-mark-predicate
;;   "\C-c\C-n" 'prolog-insert-predicate-template
;;   "\C-c\C-s" 'prolog-insert-predspec
;;   "\M-\r" 'prolog-insert-next-clause
;;   "\C-c\C-va" 'prolog-variables-to-anonymous
;;   "\C-c\C-v\C-s" 'prolog-view-predspec

;;;
(provide '10-prolog-setup)
;;; END here
