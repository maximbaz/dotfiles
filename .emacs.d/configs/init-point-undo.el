;;; package --- init-point-undo.el
;;;
;;; Commentary:
;;; PointUndo (navigate cursor positions history)
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name point-undo
   :type emacsmirror
   :features point-undo
   :after (progn
      (define-key evil-normal-state-map [M-left] 'point-undo)
      (define-key evil-normal-state-map [M-right] 'point-redo)
)))))


(provide 'init-point-undo)
;;; init-point-undo ends here
