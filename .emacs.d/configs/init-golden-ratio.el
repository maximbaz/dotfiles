;;; package --- init-golden-ratio.el
;;;
;;; Commentary:
;;; Golden Ratio (resize current split)
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name golden-ratio
   :after (progn
      (golden-ratio-mode 1)

      (diminish 'golden-ratio-mode)

      (setq golden-ratio-extra-commands
        (append golden-ratio-extra-commands
                '(evil-window-left
                  evil-window-right
                  evil-window-up
                  evil-window-down)))
)))))


(provide 'init-golden-ratio)
;;; init-golden-ratio ends here
