;;; package --- init-haskell-mode.el
;;;
;;; Commentary:
;;; Haskell major mode
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name haskell-mode
   :after (progn
      (add-hook 'haskell-mode-hook (lambda () (turn-on-haskell-indentation)))
)))))


(provide 'init-haskell-mode)
;;; init-haskell-mode ends here
