;;; package --- init-projectile.el
;;;
;;; Commentary:
;;; Projectile
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name projectile
   :after (progn
      (projectile-global-mode)
      (setq-default projectile-mode-line '(:eval (format " Proj[%s]" (projectile-project-name))))

      (evil-leader/set-key
        "g"    'helm-projectile-ag
        "d"    'helm-projectile)
)))))


(provide 'init-projectile)
;;; init-projectile ends here
