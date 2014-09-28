;;; http://howardabrams.com/projects/dot-files/emacs-eshell.html

(eval-when-compile
  (require 'cl)
  (require 'esh-mode)
  (require 'eshell))

(require 'esh-util)

(setenv "PAGER" "less")
(setq eshell-buffer-shorthand t)

(add-hook
 'eshell-mode-hook
 '(lambda nil
    (add-to-list 'eshell-visual-commands "ssh")
    (add-to-list 'eshell-visual-commands "tail")))

(defun eshell-here ()
  "Открываем eshell в каталоге с которым ассоциирован
файл находящийся в текущем буфере.
Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))

(global-set-key (kbd "C-!") 'eshell-here)

;;; Улучшаем 'историю комманд'
(add-hook
 'eshell-mode-hook
 (lambda ()
   (local-set-key (kbd "M-P") 'eshell-previous-prompt)
   (local-set-key (kbd "M-N") 'eshell-next-prompt)

   (local-set-key
    (kbd "M-r")
    (lambda ()
      (interactive)
      (insert
       (ido-completing-read "Eshell history: "
                            (delete-dups
                             (ring-elements eshell-history-ring))))))
   (local-set-key (kbd "M-S-r") 'eshell-list-history)))

(require 'em-smart)
(setq eshell-where-to-jump 'begin)
(setq eshell-review-quick-commands nil)
(setq eshell-smart-space-goes-to-end t)

;;;
(provide '03-eshell-setup)
;;; END here
