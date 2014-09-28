;;;
;;; WWW браузер w3m в окне emacs (inline!) ;-)
;;;

;;; EMACS-W3M: -> http://emacs-w3m.namazu.org/
;;; В системе нужно установить w3m, w3m-img
;;; Для emacs нужно установить emacs-w3m (ниже ссылки)
;;; через CVS:
;;; %> cvs -d :pserver:anonymous@cvs.namazu.org:/storage/cvsroot login
;;; CVS password: # No password is set.  Just hit Enter/Return key.
;;; %> cvs -d :pserver:anonymous@cvs.namazu.org:/storage/cvsroot co emacs-w3m

;;(require 'w3m)
(require 'w3m-load)

(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)

(setq w3m-use-cookies t)
(setq w3m-default-display-inline-images t)
(setq w3m-home-page "http://www.google.com/")

(setq w3m-coding-system           'utf-8)
(setq w3m-file-coding-system      'utf-8)
(setq w3m-file-name-coding-system 'utf-8)
(setq w3m-input-coding-system     'utf-8)
(setq w3m-output-coding-system    'utf-8)
(setq w3m-terminal-coding-system  'utf-8)

;;; Если в файле есть ссылка, то можно ее открыть по 'C-x m'
;;; (курсор на ссылке ;)
(defun hlp-is-url-exists()
  "проверяем, что находится под курсором:
если URL, то открываем в браузере,
а если нет, то выдаем сообщение"
  (interactive)
  (if (thing-at-point 'url)
      (browse-url-at-point)
    (message "No url's found at point!")))

(global-set-key (kbd "C-x m") 'hlp-is-url-exists)

;;; Поиск в Google 'C-x g'
(defun google-srch ()
  "Поиск в Google: если есть выделенный регион, иначе ввести текст самому"
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (url-hexify-string
     (if mark-active
         ;; FIX: (buffer-substring-no-properties ... ?
         (buffer-substring (region-beginning) (region-end))
       (read-string "Google: "))))))

(global-set-key (kbd "C-x g") 'google-srch)

;;; Поиск в Вики RU 'C-x w'
(defun lookup-wikipedia ()
  "Поиск в Вики слова под курсором, иначе ввести текст"
  (interactive)
  (browse-url
   (concat
    "http://ru.wikipedia.org/w/index.php?search="
    (url-hexify-string
     (if (use-region-p)
         (buffer-substring-no-properties (region-beginning) (region-end))
       (read-string "Wiki: "))))))

(global-set-key (kbd "C-x w") 'lookup-wikipedia)

;;;
(provide '02-w3m-setup)
;;; END here
