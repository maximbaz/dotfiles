;;; package --- init-git-gutter.el
;;;
;;; Commentary:
;;; Git Gutter
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name git-gutter
   :after (progn
      (global-git-gutter-mode t)
      (git-gutter:linum-setup)
)))))


(provide 'init-git-gutter)
;;; init-git-gutter ends here
