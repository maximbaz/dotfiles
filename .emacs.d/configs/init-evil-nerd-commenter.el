;;; package --- init-evil-nerd-commenter.el
;;;
;;; Commentary:
;;; Evil Nerd Commenter
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name evil-nerd-commenter
   :after (progn
      (require 'evil-nerd-commenter)
      (evil-leader/set-key
        "<SPC>" 'evilnc-comment-operator
        "cl"    'evilnc-quick-comment-or-uncomment-to-the-line
        "cp"    'evilnc-comment-or-uncomment-paragraphs
      )
)))))


(provide 'init-evil-nerd-commenter)
;;; init-evil-nerd-commenter ends here
