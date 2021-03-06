;;; Установить в ~/.emacs.d/plugins
;;; DISTEL:   git clone git://github.com/massemanet/distel.git
;;; WRANGLER: git clone git://github.com/RefactoringTools/wrangler.git

;;; Обязательно добавить в $HOME/.erlang file
;;; code:add_patha("~/.emacs.d/plugins/distel/ebin").
;;; code:add_path("~/.emacs.d/plugins/wrangler/ebin").

;;; FIXME: проблемы distel и wrangler. Несовместимость! ;(

;;; Основные настройки

(add-to-list
 'load-path
 (car (file-expand-wildcards "/usr/lib/erlang/lib/tools-*/emacs")))

(require 'erlang-start)

;;; Юнит тесты
(require 'erlang-eunit)

(setq erlang-root-dir "/usr/lib/erlang")
(setq erlang-man-root-dir "/usr/lib/erlang/man")
(setq exec-path (cons "/usr/lib/erlang/bin" exec-path))

(add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))
(add-to-list 'auto-mode-alist '(".*\\.app\\'" . erlang-mode))
(add-to-list 'auto-mode-alist '(".*app\\.src\\'" . erlang-mode))
(add-to-list 'auto-mode-alist '(".*\\.config\\'" . erlang-mode))
(add-to-list 'auto-mode-alist '(".*\\.rel\\'" . erlang-mode))
(add-to-list 'auto-mode-alist '(".*\\.script\\'" . erlang-mode))
(add-to-list 'auto-mode-alist '("Emakefile?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("rebar\\.*" . erlang-mode))

(add-hook
 'erlang-mode-hook
 (lambda ()
   (erlang-tags-init)
   (setq inferior-erlang-machine-options '("-sname" "emacs"))
   (setq font-lock-maximum-decoration t)
   (font-lock-mode 1)
   (if (and window-system (fboundp 'imenu-add-to-menubar))
       (imenu-add-to-menubar "eRl"))
   (setq erlang-electric-commands
         '(;;erlang-electric-comma
           erlang-electric-semicolon
           erlang-electric-gt
           ;;erlang-electric-lt
           erlang-electric-newline))
   ;; компиляция проходит с параметрами: debug_info & export_all
   ;; можно по-другому: C-u C-c C-k
   ;;(setq erlang-compile-extra-opts '(debug_info))
   (setq *erlang-indent-size* 2)
   (setq indent-tabs-mode nil)
   (setq tab-width *erlang-indent-size*)
   (setq erlang-indent-level *erlang-indent-size*)
   (setq erlang-tab-always-indent t)))

;;; Настройки Distel

(add-to-list 'load-path (concat (getenv "HOME") "/.emacs.d/plugins/distel/elisp"))

(require 'distel)

(distel-setup)

(add-hook
 'erlang-shell-mode-hook
 (lambda ()
   (erlang-tags-init)
   ;; Добавим Distel биндинги в Erlang shell
   (dolist (spec distel-shell-keys)
     (define-key erlang-shell-mode-map (car spec) (cadr spec)))))

;; Info dir
;; http://www.emacswiki.org/emacs/InfoMode
;; C-h i ...

(add-to-list
 'Info-additional-directory-list
(expand-file-name (concat (getenv "HOME") "/.emacs.d/plugins/distel/doc")))

(defconst distel-shell-keys
  '(("\C-\M-i"   erl-complete)
    ("\M-?"      erl-complete)
    ("\M-."      erl-find-source-under-point)
    ("\M-,"      erl-find-source-unwind)
    ("\M-*"      erl-find-source-unwind))
  "Additional keys to bind when in Erlang shell.")

;;; FIXME: проблемы совместимости в Distel
;;; Настройки Wrangler

;;; (Де-)активировать Wrangler: Ctrl-c Ctrl-r

;; (add-to-list 'load-path "~/.emacs.d/plugins/wrangler/elisp")

;; (require 'wrangler)

;; (load-library "graphviz-dot-mode")
;; (setq graphviz-dot-view-command "xdot %s")
;; ;;(setq wrangler-search-paths "/usr/lib/erlang/lib")


;;; Elixir ;-) (draft version)

;; TODO:
;; Почитать "спеки" для тонкой настройки
;; company mode - как связка для автокомплита и прочих плюшек
;; https://company-mode.github.io/
;; https://github.com/company-mode/company-mode

;; http://www.alchemist-elixir.org/
;; https://github.com/tonini/alchemist.el

;; alchemist via MELP
(setq alchemist-mix-command "/usr/local/bin/mix")
(setq alchemist-iex-program-name "/usr/local/bin/iex")
(setq alchemist-execute-command "/usr/local/bin/elixir")
(setq alchemist-compile-command "/usr/local/bin/elixirc")
(setq alchemist-mix-test-default-options '())
;;(setq alchemist-mix-test-task "espec") ;; <--- TODO: read docs!
(setq alchemist-test-status-modeline t)
(setq alchemist-test-mode-highlight-tests t)
(setq alchemist-test-ask-about-save nil)
(setq alchemist-test-status-modeline t)
(setq alchemist-test-display-compilation-output t)
(setq alchemist-hooks-test-on-save nil) ;; <--- TODO: read docs!
;; ac-alchemist via MELPA
(add-hook 'elixir-mode-hook 'ac-alchemist-setup)
;;; ---


;;;
(provide '11-erlang-setup)
;;; END here
