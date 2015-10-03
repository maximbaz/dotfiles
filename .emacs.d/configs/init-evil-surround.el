;;; package --- init-evil-surround.el
;;;
;;; Commentary:
;;; Evil Surround
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name evil-surround
   :after (progn
      (global-evil-surround-mode 1)
)))))


(provide 'init-evil-surround)
;;; init-evil-surround ends here
