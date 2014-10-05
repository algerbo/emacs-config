
### Текущая конфигурация emacs
------------------------------

>Памятка (клонируем на "свежий комп"):
```bash
git clone git://github.com/algerbo/emacs-config.git ~/.emcas.d
```

##### Необходимый софт: Emacs ;-) Cask

- Emacs http://www.gnu.org/software/emacs
- Cask https://github.com/cask/cask

#### Предварительные настройки:

1 Устанавливаем Cask:
```bash
 curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
 cd ~/.cask
 cask upgrade-cask
 export PATH="$HOME/.cask/bin:$PATH"
```
2 В ~/.emacs.d файл конфирурации Cask с содержимым:
```lisp
 (source "elpy" "http://jorgenschaefer.github.io/packages/")
 (source gnu)
 (source marmalade)
 (source melpa)
 (depends-on "cask")
 (depends-on "pallet")
```
3 Устанавлимаем необходимые пакеты:
```bash
 cd ~/.emacs.d
 cask install
```
4 Файл настройки emacs init.el (минимальный):
```lisp
 (require 'cask "/home/meph/.cask/cask.el")
 (cask-initialize)
 (require 'pallet)
 (mapc 'load (directory-files "/home/meph/.emacs.d/customizations" t "^[0-9]+.*\.el$"))
```

#### Необходимые телодвижения:
```bash
 mkdir -pv  ~/.emacs.d/customizations\ 
	    ~/.emacs.d/backup-customizations\
	    ~/.emacs.d/plugins
```

>Посматривай док-цию на пакеты: Cask & Pallet
>
> - Pallet https://github.com/rdallasgray/pallet
> - Cask https://github.com/cask/cask
>
>В emacs:
```
pallet-update
(см. также: pallet-init pallet-install)
```
>В шелл:
```bash
 cask outdated
 cask update
 cask [upgrade-cask|upgrade]
```

**PS: Pallet устанавливается через emacs package system (cask позаботится ;)**
