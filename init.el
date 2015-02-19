(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

;; load configuration files from here...
(mapc 'load (directory-files (concat (getenv "HOME") "/.emacs.d/customizations") t "^[0-9]+.*\.el$"))

;;; ### Следующие строки - это Emacs гадит... >=|;o)~ ###



