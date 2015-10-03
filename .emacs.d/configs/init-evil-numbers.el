;;; package --- init-evil-numbers.el
;;;
;;; Commentary:
;;; Evil Numbers (Increment & Decrement numbers)
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name evil-numbers
   :after (progn
      (define-key evil-normal-state-map (kbd "<C-up>") 'evil-numbers/inc-at-pt)
      (define-key evil-normal-state-map (kbd "<C-down>") 'evil-numbers/dec-at-pt)
)))))


(provide 'init-evil-numbers)
;;; init-evil-numbers ends here
