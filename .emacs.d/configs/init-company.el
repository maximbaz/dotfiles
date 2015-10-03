;;; package --- init-company.el
;;;
;;; Commentary:
;;; Company (autocomplete)
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name company-mode
   :after (progn
      (global-company-mode t)
      (setq-default company-idle-delay 0)
      (setq-default company-dabbrev-downcase nil)

      (diminish 'company-mode)

      ;; Fix integration of company and yasnippet
      (define-key company-active-map [tab] nil)
)))))


(provide 'init-company)
;;; init-company ends here
