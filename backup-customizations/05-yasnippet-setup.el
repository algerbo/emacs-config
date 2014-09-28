;;; From MELPA

;;; Основные настройки

(require 'yasnippet)

(yas-global-mode nil)
(yas-reload-all)
(add-hook 'prog-mode-hook '(lambda () (yas-minor-mode +1)))

(setq yas-prompt-functions
      '(yas-ido-prompt
        yas-completing-prompt
        yas-x-prompt
        yas-no-prompt))

;;; дополнитьельные каталоги со снипетами
;; (setq yas-snippet-dirs
;;       '( "/path/to/personal/snippets"
;;          "/path/to/other/snippets"))

;;; Разрешить снипеты внутри снипетов
(setq yas-triggers-in-field t)

;;; пофиксим проблемы с <TAB>, перебивает автокомплит ;(
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "C-c TAB") 'yas-expand)

;;; поддержка Ido
;;; http://www.emacswiki.org/emacs/Yasnippet
(defun yas-ido-expand ()
  "Lets you select (and expand) a yasnippet key"
  (interactive)
  (let ((original-point (point)))
    (while (and
            (not (= (point) (point-min) ))
            (not
             (string-match "[[:space:]\n]" (char-to-string (char-before)))))
      (backward-word 1))
    (let* ((init-word (point))
           (word (buffer-substring init-word original-point))
           (list (yas-active-keys)))
      (goto-char original-point)
      (let ((key (remove-if-not
                  (lambda (s) (string-match (concat "^" word) s)) list)))
        (if (= (length key) 1)
            (setq key (pop key))
          (setq key (ido-completing-read "key: " list nil nil word)))
        (delete-char (- init-word original-point))
        (insert key)
        (yas-expand)))))

;; Биндинг на Backtab: shift+tab
(define-key yas-minor-mode-map (kbd "<backtab>")     'yas-ido-expand)

;;;
(provide '05-yasnippet-setup)
;;; END here
