;;; package --- init-ace-jump.el
;;;
;;; Commentary:
;;; Ace Jump (jump to any symbol)
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name ace-jump-mode
   :after (progn
     (setq-default ace-jump-mode-case-fold nil)
     (define-key evil-normal-state-map "s" 'ace-jump-char-mode)
     (evil-define-key 'normal dired-mode-map "s" 'ace-jump-char-mode)
)))))


(provide 'init-ace-jump)
;;; init-ace-jump ends here
