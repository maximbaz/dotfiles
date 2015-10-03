;;; package --- init-undo-tree.el
;;;
;;; Commentary:
;;; Undo-Tree
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name undo-tree
   :after (progn
      (global-undo-tree-mode)
      (diminish 'undo-tree-mode)
)))))


(provide 'init-undo-tree)
;;; init-undo-tree ends here
