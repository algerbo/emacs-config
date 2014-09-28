## Текушая конфигурация emacs

####Необходимый софт: Emacs ;-) Cask
--------------------------------

[Emacs:](http://www.gnu.org/software/emacs/)
[Cask: ](https://github.com/cask/cask)

#### Предварительные настройки:

* Устанавливаем Cask:
`
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
cd ~/.cask
cask upgrade-cask
export PATH="$HOME/.cask/bin:$PATH"
`
* В ~/.emacs.d файл конфирурации Cask с содержимым:
`
(source "elpy" "http://jorgenschaefer.github.io/packages/")
(source gnu)
(source marmalade)
(source melpa)

(depends-on "cask")
(depends-on "pallet")
`
 Устанавлимаем необходимые пакеты:
`
cd ~/.emacs.d
cask install
`
* Файл настройки emacs init.el (минимальный):
`
(require 'cask "/home/meph/.cask/cask.el")
(cask-initialize)
(require 'pallet)

(mapc 'load (directory-files "/home/meph/.emacs.d/customizations" t "^[0-9]+.*\.el$"))
`
* Необходимые телодвижения:
`
mkdir -pv ~/.emacs.d/customizations ~/.emacs.d/backup-customizations ~/.emacs.d/plugins
`
*** Посматривай док-цию на пакеты: Cask & Pallet ***

[Pallet:](https://github.com/rdallasgray/pallet)
[Cask  :](https://github.com/cask/cask)

В emacs, периодически: pallet-update
(см. также: pallet-init pallet-install)
В шелл, периодически: cask outdated, cask update, cask [upgrade-cask|upgrade]

PS: Pallet устанавливается через emacs package system (cask позаботится ;)
