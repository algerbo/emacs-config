;;;
;;; Дополнительные настройки (меного плюшек)
;;;

;;; Нумерация строк
;; (require 'linum)
;; (global-linum-mode -1)
;; (setq-default linum-format (if (window-system) "%3d" "%3d "))
;; (add-hook 'prog-mode-hook (lambda () (linum-mode +1)))

;;; подбирать цвета: Alt-x list-colors-display ;0)
;;; Цвета по-умолчанию (если не использовать цветовую схему!)
;;(set-background-color "#ebebeb")
;;(set-foreground-color "#000000")

;;; подсветка строки на которую указывает курсор
;;; Цвета по-умолчанию (если не использовать цветовую схему!)
;;(global-hl-line-mode t)
;;(global-hl-line-highlight)
;;(setq global-hl-line-stiky-flag t)
;;(set-face-background 'hl-line "#f5f5f5")
;;(set-face-foreground 'hl-line "#000000")

;;; Изменить размер шрифта в граф. режиме
;;; если в терминале, то игнорируем
;; оригинальные комбинации клавиш:
;; C-x C-- уменьшить размер шрифта
;; C-x C-+ увеличить размер шрифта
;; C-x C-0 сбросить к исходному размеру (по умолчанию)
(if window-system
    (progn
      (global-set-key (kbd "C-=") 'text-scale-increase)
      (global-set-key (kbd "C--") 'text-scale-decrease))
  (progn
    (global-set-key (kbd "C-=") nil)
    (global-set-key (kbd "C--") nil)))

;;; (за\рас)комментировать выделенный регион 'C-M-;'
;;; http://rigidus.ru/articles/comment-and-search
(defun comment-or-uncomment-this (&optional lines)
  (interactive "P")
  (if mark-active
      (if (< (mark) (point))
          (comment-or-uncomment-region (mark) (point))
        (comment-or-uncomment-region (point) (mark)))
    (comment-or-uncomment-region
     (line-beginning-position)
     (line-end-position lines))))

(global-set-key (kbd "C-M-;") 'comment-or-uncomment-this)

;;; Вместо кнопы C-j для indent переназначаем на Return
(global-set-key (kbd "RET") 'newline-and-indent)
(electric-indent-mode +1)

;;; Подсветка скобок () и оп. с ними :0)
;;; Наступаем на скобку, жмем C-M-[f|b]
;;; получаем "статус" по матчингу "скобок" и т.д. ...
(global-font-lock-mode t)
(show-paren-mode t) ;; подсветка скобок ()
(setq-default show-paren-delay 0)
(setq-default show-paren-style 'expression)

(set-face-background 'show-paren-match-face "#c1ffc1")
(set-face-foreground 'show-paren-match-face "#000000")
(set-face-attribute  'show-paren-match-face nil
                     :weight 'bold :underline nil :slant 'italic)

(set-face-foreground 'show-paren-mismatch-face "#ffffff")
(set-face-background 'show-paren-mismatch-face "#ff0000")
(set-face-attribute  'show-paren-mismatch-face nil
                     :weight 'bold :underline nil :overline nil :slant 'italic)

;;; Автоматически добавлять парый символ \", \{, \(, \[ & etc.
;;; http://ergoemacs.org/emacs/emacs_insert_brackets_by_pair.html
(electric-pair-mode t)
(setq-default electric-pair-pairs
              '((?\" . ?\")
                (?\' . ?\')
                ;;(?\< . ?\>)
                (?\` . ?\`)
                (?\[ . ?\])
                (?\{ . ?\})
                (?\( . ?\))))

;;; Если в текущем режиме создается iMenu,
;;; биндим его выхов на <Win>-i
;;; FIX: under MacOSX ?
;;; if OSX... (if (equal window-system 'ns) (...))
(global-set-key [(super ?i)] 'imenu)

;;; Alt-Delete - "убить" ненужный "буфер" без вопросов ;0)
(defun absolute-kill-buffer ()
  (interactive)
  (kill-buffer (buffer-name)))

;;; FIX: under MacOSX ?
;;; if OSX... (if (equal window-system 'ns) (...))
(global-set-key [M-delete] 'absolute-kill-buffer)

;;; Ctrl-Delete - "убить" все буферы 8-[==]
(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

;;; FIX: under MacOSX ?
;;; if OSX... (if (equal window-system 'ns) (...))
(global-set-key [C-delete] 'close-all-buffers)

;;; Переименовать текущий файл и буфер "C-c r"
;;; http://emacsredux.com/blog/2013/05/04/rename-file-and-buffer/
;;; оригинальная последовательность: M-x vc-rename-file
(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(global-set-key (kbd "C-c r")  'rename-file-and-buffer)

;;; Подсветить "важные" ;) тэги с коментариях
;;; такие как: FIX:, FIXME:, TODO: ... и т.д.
;;; http://emacsredux.com/blog/2013/07/24/highlight-comment-annotations/
(defun font-lock-comment-annotations ()
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\|UNCOMPLETED\\|OVERVIEW\\|BUG\\|ERROR\\|SEE\\(TO\\)?\\):"
          1 font-lock-warning-face t))))

(add-hook 'prog-mode-hook 'font-lock-comment-annotations)

;;; Если выделить область кода, то форматирование работает с ним,
;;; иначе форматируется содержимое всего буфераю
;;; http://emacsredux.com/blog/2013/03/27/indent-region-or-buffer/
(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      (progn
        (indent-buffer)
        (message "Indented buffer.")))))

(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

;;; Полностью очистить текущий буфер 'C-c E'
;;; http://emacsredux.com/blog/2013/05/04/erase-buffer/
(put 'erase-buffer 'disabled nil)
(global-set-key (kbd "C-c E") 'erase-buffer)

;;;
(provide '01-helpers-setup)
;;; END here
