;;; package --- init-git-messenger.el
;;;
;;; Commentary:
;;; Git Messenger (show commits in pop-up)
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name git-messenger
   :after (progn
      (evil-leader/set-key
        "gm" 'git-messenger:popup-message)
)))))


(provide 'init-git-messenger)
;;; init-git-messenger ends here
