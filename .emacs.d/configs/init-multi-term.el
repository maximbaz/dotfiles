;;; package --- init-multi-term.el
;;;
;;; Commentary:
;;; MultiTerm
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name multi-term
   :after (progn
      (setq-default multi-term-program "/bin/zsh")

      ;; Open terminal
      (global-set-key [f9] 'multi-term)

      (add-hook 'term-mode-hook
        (lambda ()
          (setq-default term-buffer-maximum-size 10000)
          (autopair-mode -1)))
)))))


(provide 'init-multi-term)
;;; init-multi-term ends here
