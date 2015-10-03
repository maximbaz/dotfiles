;;; package --- init-evil-matchit.el
;;;
;;; Commentary:
;;; Evil MatchIt
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name evil-matchit
   :after (progn
      (global-evil-matchit-mode 1)
)))))


(provide 'init-evil-matchit)
;;; init-evil-matchit ends here
