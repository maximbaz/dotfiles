;;; package --- init-emmet-mode.el
;;;
;;; Commentary:
;;; Emmet mode
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name emmet-mode
   :after (progn
      (add-hook 'sgml-mode-hook 'emmet-mode)
      (add-hook 'css-mode-hook  'emmet-mode)
)))))


(provide 'init-emmet-mode)
;;; init-emmet-mode ends here
