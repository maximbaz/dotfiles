;;; package --- init-less-css-mode.el
;;;
;;; Commentary:
;;; LESS mode
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name less-css-mode
   :after (progn
       (setq-default css-indent-offset 2)
)))))


(provide 'init-less-css-mode)
;;; init-less-css-mode ends here
