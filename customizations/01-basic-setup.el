;;;
;;; Базовые настройки.
;;;

;;; нет сплашскрину ;-) 
(setq inhibit-splash-screen t)
;;; "чистая" echo area при старте
(setq inhibit-startup-echo-area-message t)

;;; В буфер *scratch* отобразим "свои" биндинги
;;(setq initial-scratch-message "")
(defun prepare-scratch-buffer ()
  (let ((file (concat (getenv "HOME") "/.emacs.d/Cheatsheet")))
    (when (file-exists-p file)
      (set-buffer (get-buffer "*scratch*"))
      (erase-buffer)
      (insert-file-contents file)
      (read-only-mode t))))
(prepare-scratch-buffer)

;;; Визуальная индикация "исключений", пр.: 'C-g'
;;; "умолчальный вариант"
;;(setq visible-bell t)
;;; Вариант: инверсия статусной строки
(defun my-terminal-visible-bell ()
  "A friendlier visual bell effect."
  (invert-face 'mode-line)
  (run-with-timer 0.1 nil 'invert-face 'mode-line))

(setq visible-bell nil
      ring-bell-function 'my-terminal-visible-bell)

;;; 4 R3Al Emacs hacker-Zzz... ;-)
;;(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;;; set up unicode
;;; keyboard / input method settings
(setq locale-coding-system              'utf-8)
(set-terminal-coding-system             'utf-8)
(set-keyboard-coding-system             'utf-8)
(set-selection-coding-system            'utf-8)
(set-language-environment               'UTF-8)
(set-default-coding-systems             'utf-8)
(setq buffer-file-coding-system         'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
(prefer-coding-system                   'utf-8)
(setq buffer-file-coding-system         'utf-8-unix)
(setq default-file-name-coding-system   'utf-8-unix)
(setq default-keyboard-coding-system    'utf-8-unix)
(setq default-process-coding-system     '(utf-8-unix . utf-8-unix))
(setq default-sendmail-coding-system    'utf-8-unix)
(setq default-terminal-coding-system    'utf-8-unix)
(setq coding-system-for-read            'utf-8)
(setq coding-system-for-write           'utf-8)

;;; Показывать номера текущей колонки и строки
(line-number-mode t)
(column-number-mode t)

;;; Не мигать курсором
(blink-cursor-mode 0)

;;; величина скроллинга
(setq scroll-step 1)

;;; Вместо yes/no вводим y/n
(fset 'yes-or-no-p 'y-or-n-p)

;;; "Разбивка" буфера, приоритет ГОРИЗОНТАЛЬНО
(setq split-width-threshold 9999)
;;; Разбивка буфера, приоритет ВЕРТИКАЛЬНО
;;(setq split-width-threshold nil)
;;; Сбалансировать размер окон
;;; C-x + is bound to by default

;;; http://rigidus.ru/articles/buffers
;;; Изменить содержимое текущего буфера
;;; переключаясь на следующий или предыдущий
;;; ->,<- курсорные клавиши
;;; C-x -> & C-x <-
;;; C-x C- -> & C-x C- ->

;;; По-умолчанию, переходим между окнами 'C-x o'
;;; Добавим переход по: alt + \курсорные клавиши\.
(windmove-default-keybindings 'meta)

;;; CUA режим: совместимость в Windoze...
;; (setq cua-enable-cua-keys t)
;; (cua-mode t)
;;; Emacs CUA    Function
;;; C-_   C-z    undo
;;; C-w   C-x    cut
;;; M-w   C-c    copy
;;; C-y   C-v    paste

;;; Размеры отступов по-умолчанию
;;; Пробелы в качестве отступов (no TAB's!)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq tab-width 2)

;;; 1. Удалить пустые строки и левые пробелы
;;; 2. Пометить строки (и еще кое что ;) длинной более 80 символов
(require 'whitespace)
(setq whitespace-style '(face tabs tab-mark trailing lines-tail))
(setq whitespace-line-column 80)
(global-whitespace-mode t)
(setq-default show-trailing-whitespace t)
(setq-default indicate-empty-lines t)

;;; автосохранение
(setq auto-save-interval 180)
(setq auto-save-timeout   30)

;;; чистимся...
(defun cleaning-garbage ()
  (progn
    (delete-trailing-whitespace)
    (whitespace-cleanup)))

;;; Перед сохранением почистим мусор...
(add-hook 'before-save-hook 'cleaning-garbage)

;;; По 'C-k' удаляется строка + получившеяся пустая строка
(setq kill-whole-line t)

;;; Еще одна "плюшечка" ;-)
;;; Автоматически сохряняем буферы в которых были изменения
(defun full-auto-save ()
  "Проверяем все буфферы и сохраняем измененные"
  (interactive)
  (save-excursion
    (dolist (buf (buffer-list))
      (set-buffer buf)
      (if (and (buffer-file-name) (buffer-modified-p))
          (progn
            (basic-save-buffer)
            (message "Auto save buffer: %s" buf))))))

;;; Вешаем 'полное сохранение' на хук
(add-hook 'auto-save-hook 'full-auto-save)



;;;;                 -= ШНЯГА =-
;;; временно:
(setq make-backup-files nil) ; stop creating those backup~ files
(setq auto-save-default nil) ; stop creating those #autosave# files

;; How to Delete Emacs Backup Files:
;;call: dired
;;call: dired-flag-backup-files【~】 mark all backup files for deletion.
;;call: dired-do-flagged-delete【x】(execute) delete files flagged for deletion.

;;;
;;; FIXME: Не работает!!!!
;;;

;;; Авто-сэйвы и бак-апы

;; (defun hlp-create-dir ()
;;   "Создаем каталоги если отсутствует.
;; Вложенные каталоги не создаются автоматически, поэтому важна
;; последовательность в их указании. Сначала 'верхний' каталог, потом суб-"
;;   (let*
;;       ((subdirs '("backups" "backups/auto-save" "backups/files"))
;;        (fulldirs (mapcar (lambda (d) (concat user-emacs-directory d)) subdirs)))
;;     (dolist (dir fulldirs)
;;       (when (not (file-exists-p dir))
;;         (make-directory dir)
;;         (message "[Backups\\Autosave] Make directory: %s" dir)))))

;; ;;; Повесим хук на старт, нужно создать необходимые каталоги
;; (add-hook 'after-init-hook 'hlp-create-dir)

;; ;;; auto save:

;; (defconst hlp-auto-save-dir
;;   (format "%s%s/" user-emacs-directory  "backups/auto-save"))

;; (setq auto-save-interval 120) ;; сохраняться каждые 2 мин.
;; (setq auto-save-timeout  30) ;; отслеживать простой (Idle 30 sec.)
;; ;;(setq auto-save-visited-file-name t)
;; (setq auto-save-list-file-prefix (concat hlp-auto-save-dir "saves-"))

;; ;;; FIXME: подобрать корректный шаблон:
;; ;; (setq auto-save-file-name-transforms
;; ;;       `(("\\`/[^/]*:\\([^/]*/\\)*\\([^/]*\\)\\'" ,hlp-auto-save-dir t)))
;; (setq auto-save-file-name-transforms
;;       `((".*" ,hlp-auto-save-dir t)))

;; ;;; backup's:

;; (defconst hlp-backup-dir
;;   (format "%s%s" user-emacs-directory "backups/files"))

;; (setq backup-directory-alist `(("" . ,hlp-backup-dir)))
;; (setq make-backup-files t)
;; (setq backup-by-copying t)
;; (setq backup-by-copying-when-mismatch t)
;; (setq backup-by-copying-when-linked t)
;; (setq version-control t)
;; (setq delete-old-versions t)
;; (setq kept-new-version 9)
;; (setq kept-old-wersions 3)

;;;
(provide '01-basic-setup)
;;; END here
