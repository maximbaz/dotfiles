;;; package --- init.el
;;;
;;; Commentary:
;;; Emacs configuration
;;;
;;; Code:


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)


;; Debug while doing initialization
(setq debug-on-error t)

;; Require common-lisp
(require 'cl)


;; Keep Custom settings in a separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)


;; Load personal configuration
(add-to-list 'load-path (expand-file-name "configs" user-emacs-directory))


;; Native Emacs config, custom functions and
;; package manager initialization.
(require 'init-functions)
(require 'init-base)
(require 'init-el-get)


;; Popular dependencies.
;; Revisit other configs, if deleting one of these.
(require 'init-diminish)
(require 'init-evil-leader)
(require 'init-evil)


;; Other plugins.
;; Tend to be mutually independent.
(require 'init-ace-jump)
(require 'init-anzu)
(require 'init-coffee-mode)
(require 'init-colorscheme)
(require 'init-company)
(require 'init-company-ghc)
(require 'init-dired)
(require 'init-emmet-mode)
(require 'init-evil-matchit)
(require 'init-evil-nerd-commenter)
(require 'init-evil-numbers)
(require 'init-evil-surround)
(require 'init-expand-region)
(require 'init-fic)
(require 'init-git-gutter)
(require 'init-git-messenger)
(require 'init-git-modes)
(require 'init-git-timemachine)
(require 'init-golden-ratio)
(require 'init-google-this)
(require 'init-haskell-mode)
(require 'init-helm)
(require 'init-helm-company)
(require 'init-less-css-mode)
(require 'init-markdown-mode)
;; TODO cannot download from github
;; (require 'init-multi-term)
(require 'init-org-mode)
(require 'init-point-undo)
(require 'init-projectile)
(require 'init-rainbow-delimeters)
(require 'init-slim-mode)
(require 'init-smart-home-end)
(require 'init-smart-mode-line)
(require 'init-undo-tree)
(require 'init-yasnippet)


(cond ((my/is-linux)
  (require 'init-magit)    ; requires install-info, cannot find such for msys
  (require 'init-flycheck) ; requires texinfo5+, msys has texinfo4
))


;; Load machine-specific settings if they exist
(require 'machine (expand-file-name "machine.el" user-emacs-directory) t)


(setq packages-list (mapcar 'el-get-as-symbol (mapcar 'el-get-source-name el-get-sources)))
(el-get 'sync packages-list)


;; Turn off debugging at this point
(setq debug-on-error nil)


(provide 'init)
;;; init ends here
