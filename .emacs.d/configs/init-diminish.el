;;; package --- init-diminish.el
;;;
;;; Commentary:
;;; Diminish mode line
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name diminish
   :after (progn
      (diminish 'visual-line-mode)
      (diminish 'global-whitespace-mode)
      (add-hook 'prog-mode-hook '(lambda () (diminish 'subword-mode)) 'append)
)))))


(provide 'init-diminish)
;;; init-diminish ends here
