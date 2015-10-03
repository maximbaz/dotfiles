;;; package --- init-colorscheme.el
;;;
;;; Commentary:
;;; Color scheme
;;;
;;; Code:


;; Color scheme
(setq el-get-sources (append el-get-sources '(
  (:name color-theme-zenburn
   :after (progn
      (load-theme 'zenburn t)
)))))


(provide 'init-colorscheme)
;;; init-colorscheme ends here
