;;; package --- init-magit.el
;;;
;;; Commentary:
;;; MaGit
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name magit)
)))

;; TODO: Configure magit
;; (evil-set-initial-state 'magit-mode 'normal)
;; (evil-set-initial-state 'magit-status-mode 'normal)
;; (evil-set-initial-state 'magit-diff-mode 'normal)
;; (evil-set-initial-state 'magit-log-mode 'normal)
;; (evil-define-key 'normal magit-mode-map
;;     "j" 'magit-goto-next-section
;;     "k" 'magit-goto-previous-section)
;; (evil-define-key 'normal magit-log-mode-map
;;     "j" 'magit-goto-next-section
;;     "k" 'magit-goto-previous-section)
;; (evil-define-key 'normal magit-diff-mode-map
;;     "j" 'magit-goto-next-section
;;     "k" 'magit-goto-previous-section)



(provide 'init-magit)
;;; init-magit ends here
