;;; From MELPA

;;; SEE:
;;; http://www.masteringemacs.org/articles/2010/10/10/introduction-to-ido-mode/

;;; Основные настройки Ido-mode

(ido-mode 1)

;;; FIXME: см. далее! Как вызвать правильнее?
(setq ido-everywhere t)
;;; FIXME: избыточно?
(ido-everywhere +1)

;;; не создавать файлы истории и прочее
(setq ido-enable-last-directory-history nil)
(setq ido-record-commands nil)
(setq ido-max-work-directory-list 0)
(setq ido-max-work-file-list 0)

(defun ibuffer-ido-find-file (file &optional wildcards)
  "Like `ido-find-file', but default to the directory of the buffer at point."
  (interactive
   (let ((default-directory
           (let ((buf (ibuffer-current-buffer)))
             (if (buffer-live-p buf)
                 (with-current-buffer buf
                   default-directory)
               default-directory))))
     (list (ido-read-file-name "Find file: " default-directory) t)))
  (find-file file wildcards))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (define-key ibuffer-mode-map "\C-x\C-f"
              'ibuffer-ido-find-file)))

(setq ido-use-filename-at-point 'guess)
(setq ido-create-new-buffer 'always)
(setq confirm-nonexistent-file-or-buffer nil)
(setq ido-use-face t)
(setq ido-enable-flex-matching t)

;;; Не создавать recentf файлы (просто хлам?)
;;; А также не читать из emacs Recent files
(setq ido-use-virtual-buffers nil)
(setq ido-virtual-buffers nil)

;;; Личные предпочтения ;) сортировки.
(setq ido-file-extensions-order
      '(
        ;; Lisp:
        ".el" ".lisp" ".lsp" ".asd" ".cl" ".system"
        ;; Erlang:
        ".erl" ".hrl" ".app" ".src" ".rel" ".script" ".config"
        ;; Python:
        ".py" ".py3" ".pyx" ".pxd"
        ))

(defun cool-buffer-list-view ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (ibuffer))

(global-set-key (kbd "C-x C-b") 'cool-buffer-list-view)

;;; Дополнительный пакет MELPA: ido-select-window
;;;  настройки ido-select-window слегка продвинутый: switch-window
(global-set-key (kbd "C-x o") 'ido-select-window)

;;; Дополнительный пакет MELPA: ido-vertical-mode
;;; настройки ido-vertical-mode
(ido-vertical-mode 1)

;;; устранить несовместимость вертикального режима ido
;;; в Dired режиме, при копировании файлов и прочее...
(defun disable-ido-everywhere ()
  (ido-everywhere -1))

(add-hook 'dired-mode-hook 'disable-ido-everywhere)

;;; Дополнительный пакет MELPA: flx-ido
;;; улучшаем автодополнение, подсветку...

(require 'flx-ido)

(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

;;;
(provide '02-ido-setup)
;;; END here
