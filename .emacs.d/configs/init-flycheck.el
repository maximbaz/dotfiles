;;; package --- init-flycheck.el
;;;
;;; Commentary:
;;; Flycheck (linter)
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name flycheck
   :after (progn
      (add-hook 'prog-mode-hook 'flycheck-mode)
      (setq-default flycheck-display-errors-delay 0.2)
)))))


(provide 'init-flycheck)
;;; init-flycheck ends here
