;;; https://www.gnu.org/software/emacs/manual/html_node/ediff/
;;; http://www.emacswiki.org/emacs/EdiffMode

(require 'ediff)

;; При вызове из коммандной строки:
;; emacs -diff file1 file2
(defun command-line-diff (switch)
  (let ((file1 (pop command-line-args-left))
        (file2 (pop command-line-args-left)))
    (ediff file1 file2)))
(add-to-list 'command-switch-alist '("diff" . command-line-diff))
(add-to-list 'command-switch-alist '("-diff" . command-line-diff))

;;; Разбиение окна зависит от его текущей ширины
;;(setq ediff-split-window-function
;;	  (if (> (frame-width) 150)
;;		  'split-window-horizontally
;;		'split-window-vertically))

;;; Явно разбиваем
(setq ediff-split-window-function 'split-window-horizontally)

;; Поднастроим цвета
;; https://www.gnu.org/software/emacs/manual/html_node/ediff/Customization.html
(add-hook 'ediff-load-hook
          (lambda ()
            (set-face-foreground
             ediff-current-diff-face-B "blue")
            (set-face-background
             ediff-current-diff-face-B "red")
            (make-face-italic
             ediff-current-diff-face-B)))

;;;
(provide '03-ediff-setup)
;;; END here
