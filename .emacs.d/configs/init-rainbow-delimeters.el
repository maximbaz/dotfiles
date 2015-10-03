;;; package --- init-rainbow-delimeters.el
;;;
;;; Commentary:
;;; Colorize nested patentheses
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name rainbow-delimiters
   :after (progn
      (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
)))))


(provide 'init-rainbow-delimeters)
;;; init-rainbow-delimeters ends here
