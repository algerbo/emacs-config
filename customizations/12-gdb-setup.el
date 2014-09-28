;;; Настройки отладчика GDB

;;; FIXME: настройка не закончена !!!!
;;; FIX:   не работает "автозакрытие окон" после завершения отладки!!!
;;; FIX:   не работает "вывод" программы во время отладки, прим. printf(...)
;;; FIX:   удалить автокомплит в gdb-mode-hook ??? МЕШАЕТ в косоли gdb !!!
;;; SEE:   детально отточить настройки !!!

;;; FIX: ???
;; (defun easy-gdb-hook ()
;;   (message nil)
;;   (setq indent-line-function 'gud-gdb-complete-command)
;;   ;;(setq gdb-show-main t)
;;   (local-set-key [f5]          'gdb-restore-windows)
;;   (local-set-key [M-up]        'gdb-io-buffer-off  )
;;   (local-set-key [M-down]      'gdb-io-buffer-on   )
;;   (local-set-key [?\C-c ?\C-q] 'comint-quit-subjob )
;;   (defun gdb-io-buffer-off () "Enable separate IO buffer." (interactive)(gdb-use-separate-io-buffer nil))
;;   (defun gdb-io-buffer-on () "Disable separate IO buffer." (interactive)(gdb-use-separate-io-buffer t)))
;; (add-hook 'gdb-mode-hook 'easy-gdb-hook)

(require 'gdb-mi)

;;; Основные настройки GDB режима
(setq gdb-many-windows t)
(setq gdb-show-main t)
(setq gud-chdir-before-run nil)
(setq gud-tooltip-mode t)
(setq gdb-use-separate-io-buffer t)
(setq gdb-find-source-frame nil)
(setq gdb-use-colon-colon-notation t)

;;; Своя подсветка 'отлаживаемой строки'
(make-face 'hlp-curr-line-face)
(set-face-attribute 'hlp-curr-line-face nil
                    :inherit 'secondary-selection
                    :foreground "#000000"
                    :background "#ff3030"
                    :weight 'bold)

(defvar gud-overlay
  (let* ((ov (make-overlay (point-min) (point-min))))
    (overlay-put ov 'face 'hlp-curr-line-face)
    ov)
  "Overlay variable for GUD highlighting.")

(defadvice gud-display-line (after my-gud-highlight act)
  "Highlight current line."
  (let* ((ov gud-overlay)
         (bf (gud-find-file true-file)))
    (save-excursion
      (set-buffer bf)
      (move-overlay ov (line-beginning-position) (line-end-position)
                    (current-buffer)))))

;;; При закрытии отладки восстанавливаем исх. состояние
;;; т.е. закрываем GUD буфер по 'C-x k'
(defun gud-kill-buffer ()
  (if (eq major-mode 'gud-mode)
      (progn
        (delete-overlay gud-overlay)
        (gdb-restore-windows))))

(add-hook 'kill-buffer-hook 'gud-kill-buffer)

;;; FIX: ???
(defun xyt/gdb-hotkey-hook ()
  (local-set-key (kbd "C-c C-.") 'gdb-restore-windows))

(add-hook 'gdb-mode-hook 'xyt/gdb-hotkey-hook)

;;;
(provide '12-gdb-setup)
;;; END here
