;;; package --- init-ghc-mod.el
;;;
;;; Commentary:
;;; ghc-mod for Emacs.
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name ghc-mod
   :pkgname "DanielG/ghc-mod"
   :after (progn
      (autoload 'ghc-init "ghc" nil t)
      (autoload 'ghc-debug "ghc" nil t)
      (add-hook 'haskell-mode-hook (lambda () (ghc-init)))
)))))


(provide 'init-ghc-mod)
;;; init-ghc-mod ends here
