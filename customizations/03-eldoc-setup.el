;;;
;;; Справка eldoc
;;;

;;; Добавляем хуки
;;; "хуки режимов" для eldoc добавиляем с список, см. ниже
(dolist
    (hook
     (list
      'ielm-mode-hook
      'emacs-lisp-mode-hook
      'lisp-interaction-mode-hook
      'message-mode-hook
      'Info-mode-hook
      'eval-expression-minibuffer-setup-hook
      'lisp-mode-hook
      'slime-mode-hook
      'slime-repl-mode-hook
      ))
  (add-hook hook
            '(lambda ()
              (progn
                (require 'eldoc)
                (setq eldoc-idle-delay 1.0)
                (setq eldoc-print-after-edit nil)
                (setq eldoc-echo-area-use-multiline-p t)
                (turn-on-eldoc-mode)))))

;;; 'C-c h' дважды, просмотр док-ции на 'содержимое' под курсором...
;;; открываетс отдельный *Help* буфер
;; (defun rgr/toggle-context-help ()
;;   "Turn on or off the context help.
;; Note that if ON and you hide the help buffer then you need to
;; manually reshow it. A double toggle will make it reappear"
;;   (interactive)
;;   (with-current-buffer (help-buffer)
;;     (unless (local-variable-p 'context-help)
;;       (set (make-local-variable 'context-help) t))
;;     (if (setq context-help (not context-help))
;;         (progn
;;           (if (not (get-buffer-window (help-buffer)))
;;               (display-buffer (help-buffer)))))
;;     (message "Context help %s" (if context-help "ON" "OFF"))))

;; (defun rgr/context-help ()
;;   "Display function or variable at point in *Help* buffer if visible.
;; Default behaviour can be turned off by setting the buffer local
;; context-help to false"
;;   (interactive)
;;   ;; symbol-at-point http://www.emacswiki.org/cgi-bin/wiki/thingatpt%2B.el
;;   (let ((rgr-symbol (symbol-at-point)))
;;     (with-current-buffer (help-buffer)
;;       (unless (local-variable-p 'context-help)
;;         (set (make-local-variable 'context-help) t))
;;       (if (and context-help (get-buffer-window (help-buffer))
;;                rgr-symbol)
;;           (if (fboundp  rgr-symbol)
;;               (describe-function rgr-symbol)
;;               (if (boundp  rgr-symbol) (describe-variable rgr-symbol)))))))

;; (defadvice eldoc-print-current-symbol-info
;;     (around eldoc-show-c-tag activate)
;;   (cond
;;     ((eq major-mode 'emacs-lisp-mode)       (rgr/context-help) ad-do-it)
;;     ((eq major-mode 'lisp-interaction-mode) (rgr/context-help) ad-do-it)
;;     ((eq major-mode 'apropos-mode)          (rgr/context-help) ad-do-it)
;;     ((eq major-mode 'lisp-mode)             (rgr/context-help) ad-do-it)
;;     ((eq major-mode 'slime-mode)            (rgr/context-help) ad-do-it)
;;     (t ad-do-it)))

;;; по умолчанию, док-ция отображается с строке minibuffer-a
;;; ?дважды? набрав 'C-c h' получим окно *Help* с динамически
;;; отслеживаемой док-цией (ищется для текста под курсором)
;; (global-set-key (kbd "C-c h") 'rgr/toggle-context-help)

;;;
(provide '03-eldoc-setup)
;;; END here
