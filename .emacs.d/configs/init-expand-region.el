;;; package --- init-expand-region.el
;;;
;;; Commentary:
;;; Expand region of visual selection
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name expand-region
   :after (progn
      (define-key evil-visual-state-map "R" 'er/expand-region)
)))))


(provide 'init-expand-region)
;;; init-expand-region ends here
