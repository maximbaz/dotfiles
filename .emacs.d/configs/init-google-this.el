;;; package --- init-google-this.el
;;;
;;; Commentary:
;;; Google this
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name google-this
   :after (progn
      (google-this-mode t)

      (diminish 'google-this-mode)

      (evil-leader/set-key
        "gt"  'google-this-noconfirm)
)))))


(provide 'init-google-this)
;;; init-google-this ends here
