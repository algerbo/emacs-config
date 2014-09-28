;;; MAXIMA lisp algebra

(add-to-list
 'load-path
 (car (file-expand-wildcards "/home/meph/0LISP/0MAXIMA/share/maxima/*/emacs")))

(setq exec-path (append exec-path '("/home/meph/0LISP/0MAXIMA/bin")))
(setenv "PATH" (concat (getenv "PATH") ":/home/meph/0LISP/0MAXIMA/bin"))

(autoload 'imaxima "imaxima" "Frontend for maxima with Image support" t)
(autoload 'maxima "maxima" "Maxima interaction" t)
(autoload 'imath-mode "imath" "Imath mode for math formula input" t)
(autoload 'maxima-mode "maxima" "Maxima editing mode" t)
(add-hook 'emaxima-mode-hook 'emaxima-mark-file-as-emaxima)

(setq imaxima-use-maxima-mode-flag t)
(setq imaxima-fnt-size "large")
(setq imaxima-pt-size 12)
(setq maxima-use-full-color-in-process-buffer t)

;; Info dir
;; http://www.emacswiki.org/emacs/InfoMode
;; C-h i ...
(setq Info-default-directory-list
      (append Info-default-directory-list
              '("/home/meph/0LISP/0MAXIMA/share/info")))

(add-hook 'inferior-maxima-mode-hook
          (lambda ()
            (local-set-key (kbd "TAB") 'maxima-complete)))

(add-to-list 'auto-mode-alist '("\\.ma[cx]" . maxima-mode))

;;;
(provide '09-maxima-setup)
;;; END here
