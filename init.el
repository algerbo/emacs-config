(require 'cask "/home/meph/.cask/cask.el")
(cask-initialize)
(require 'pallet)

;; load configuration files from here...
(mapc 'load (directory-files "/home/meph/.emacs.d/customizations" t "^[0-9]+.*\.el$"))

;;; ### Ниже Emacs гадит... >=|;o)~ ###



