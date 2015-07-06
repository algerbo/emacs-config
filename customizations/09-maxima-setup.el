;;; MAXIMA lisp algebra

(add-to-list
 'load-path
 (car (file-expand-wildcards
       (concat (getenv "HOME") "/0LISP/0MAXIMA/share/maxima/*/emacs"))))

(add-to-list
 'exec-path
 (concat (getenv "HOME") "/0LISP/0MAXIMA/bin"))

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

(add-to-list
 'Info-additional-directory-list
 (expand-file-name (concat (getenv "HOME") "/0LISP/0MAXIMA/share/info")))

(add-hook 'inferior-maxima-mode-hook
          (lambda ()
            (local-set-key (kbd "TAB") 'maxima-complete)))

(add-to-list 'auto-mode-alist '("\\.ma[cx]" . maxima-mode))
(add-to-list 'auto-mode-alist '("\\.maxima" . maxima-mode))

;;;
(provide '09-maxima-setup)
;;; END here
