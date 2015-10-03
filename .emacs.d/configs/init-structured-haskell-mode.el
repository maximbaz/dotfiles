;;; package --- init-structured-haskell-mode.el
;;;
;;; Commentary:
;;; Structured editing for Haskell
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name structured-haskell-mode
   :after (progn
      (add-hook 'haskell-mode-hook 'structured-haskell-mode)
)))))


(provide 'init-structured-haskell-mode)
;;; init-structured-haskell-mode ends here
