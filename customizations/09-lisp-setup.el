;;; LISP & SBCL & SLIME
;;; установить SLIME из https://github.com/slime/slime
;;; ~/.emacs.d/plugins

;;; при установке через QuickLisp:
;;(load (expand-file-name "~/0LISP/QUICKLISP/slime-helper.el"))

;;; при установке через Git
;(add-to-list 'load-path (concat (getenv "HOME") "/.emacs.d/plugins/slime"))
;;; предыдущие телодвижения лишние :-( ac-slime тянет за собой slime :-(
(require 'slime-autoloads)

;;; НАСТРОЙКИ ->

(setq auto-mode-alist
      (append '(("\\.lisp$"   . lisp-mode)
                ("\\.lsp$"    . lisp-mode)
                ("\\.cl$"     . lisp-mode)
                ("\\.asd$"    . lisp-mode)
                ("\\.system$" . lisp-mode))
              auto-mode-alist))

(slime-setup '(slime-asdf
               slime-autodoc
               slime-banner
               slime-editing-commands
               slime-fancy
               slime-fancy-inspector
               slime-fontifying-fu
               slime-fuzzy
               slime-indentation
               ;;slime-mdot-fu ;; Not implemented. error: This contrib does not work at the moment.
               ;;slime-highlight-edits
               slime-package-fu
               slime-references
               slime-repl
               slime-sbcl-exts
               slime-scratch
               slime-tramp
               slime-asdf
               slime-sprof
               slime-xref-browser
               slime-trace-dialog))

(setq slime-net-coding-system 'utf-8-unix)

;;; --no-linedit этот пакет для удобства при работе в терминеле К.С.
;(setq inferior-lisp-program "/usr/local/bin/sbcl --noinform --no-linedit")
;; выбор лиспа при запуске слима: M-- M-x slime
(setq slime-lisp-implementations
      '((clozure ("/home/meph/bin/clozure" "-K utf-8") :coding-system utf-8-unix)
        (sbcl ("/usr/local/bin/sbcl" "--noinform --no-linedit") :coding-system utf-8-unix)))
;; по-умолчанию (старт slime без префикса) M-x slime стартонем SBCL
(setf slime-default-lisp 'sbcl)

(eval-after-load
    'slime
  '(progn
     (setq common-lisp-hyperspec-root (concat "file://" (getenv "HOME") "/0LISP/HyperSpec/"))
     (setq common-lisp-hyperspec-symbol-table (concat "file://" (getenv "HOME") "/0LISP/HyperSpec/Data/Map_Sym.txt"))
     (setq slime-scratch-file (concat (getenv "HOME") "/0LISP/tmp/scratch.lisp"))
     (setq slime-edit-definition-fallback-function 'find-tag)
     (setq slime-complete-symbol*-fancy t)
     (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
     (setq slime-when-complete-filename-expand t)
     (setq slime-truncate-lines nil)
     (setq slime-autodoc-use-multiline-p t)
     (setq slime-load-failed-fasl 'never)
     ;; подсвечиваем "измененные строки" ;-)
     ;;(setq slime-highlight-edits-mode t)
     ;;(set-face-background 'slime-highlight-edits-face "dark turquoise")
     ;;(set-face-foreground 'slime-highlight-edits-face "red")
     (setq slime-autodoc-mode t)
     (setq slime-repl-history-remove-duplicates t)
     (setq slime-highlight-compiler-notes t)
     (setq slime-repl-history-trim-whitespaces nil)))

(define-key slime-mode-map
  (kbd "TAB") 'slime-indent-and-complete-symbol)

(add-hook 'lisp-mode-hook
          (lambda ()
            (setq lisp-indent-function 'common-lisp-indent-function)
            (setq slime-use-autodoc-mode t)
            (setq show-trailing-whitespace t)))

(defun my/customized-lisp-keyboard ()
  (define-key slime-repl-mode-map (kbd "C-c ;") 'slime-insert-balanced-comments)
  (local-set-key [C-tab] 'slime-fuzzy-complete-symbol)
  (local-set-key [return] 'reindent-then-newline-and-indent)
  (local-set-key [f11] 'slime-list-compiler-notes)
  (local-set-key [f12] 'slime-cheat-sheet)
  (local-set-key [(control f12)] 'slime-selector)
  (local-set-key (kbd "C-\\") 'lisp-complete-symbol)
  (local-set-key (kbd "M-\\") 'lisp-complete-symbol)
  (local-set-key (kbd "C-c s") 'slime-format-string-expand))

(add-hook 'lisp-mode-hook 'my/customized-lisp-keyboard)

;;; FIXME: вероятно избыточное переопределение?
(defun hlp-custom-keys ()
  (define-key slime-repl-mode-map (kbd "C-<tab>") 'slime-fuzzy-complete-symbol)
  (define-key slime-mode-map (kbd "C-<tab>") 'slime-fuzzy-complete-symbol))

(add-hook 'slime-load-hook 'hlp-custom-keys)

;;; Док-цию смотрим в w3m
;;; REVIEW: последние версии emacs имеют встроенную поддержку eww ("новый www browser")
;;;         see to: /path/to/sources/emacs-x/lisp/net/eww.el
(require 'hyperspec)

(defun hyperspec-lookup (&optional symbol-name)
  (interactive)
  (let ((browse-url-browser-function 'eww-browse-url)) ;;; 'w3m-browse-url))
    (if symbol-name
        (common-lisp-hyperspec symbol-name)
      (call-interactively 'common-lisp-hyperspec))))

;;; Автокомплит
;;; Доп. пакеты MELPA:
;;; ac-slime, auto-complete, fuzzy, pos-tip

(require 'auto-complete)
(require 'ac-slime)
(require 'fuzzy)
(require 'pos-tip)

(add-hook 'lisp-mode-hook 'set-up-slime-ac)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-mode))
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'lisp-mode))

;;; Улучшаем "качество" вып.меню
;;; http://www.emacswiki.org/emacs-en/PosTip

(defadvice popup-menu-show-quick-help
    (around pos-tip-popup-menu-show-quick-help () activate)
  "Show quick help using `pos-tip-show'."
  (if (eq window-system 'x)
      (let ((doc (popup-menu-document
                  menu (or item
                           (popup-selected-item menu)))))
        (when (stringp doc)
          (pos-tip-show doc nil
                        (if (popup-hidden-p menu)
                            (or (plist-get args :point)
                                (point))
                          (overlay-end (popup-line-overlay
                                        menu (+ (popup-offset menu)
                                                (popup-selected-line menu)))))
                        nil 0)
          nil))
    ad-do-it))

;;;
(provide '09-lisp-setup)
;;; END here
