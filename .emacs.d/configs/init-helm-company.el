;;; package --- init-helm-company.el
;;;
;;; Commentary:
;;; Helm for Company
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name helm-company
   :depends (helm)
   :after (progn
      (define-key company-mode-map (kbd "C-:") 'helm-company)
      (define-key company-active-map (kbd "C-:") 'helm-company)
)))))


(provide 'init-helm-company)
;;; init-helm-company ends here
