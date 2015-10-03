;;; package --- init-anzu.el
;;;
;;; Commentary:
;;; Anzu (show number of search matches)
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name evil-anzu
   :type github
   :pkgname "syohex/emacs-evil-anzu"
   :depends (evil anzu)
   :features (evil-anzu)
   :after (progn
      (global-anzu-mode t)
      (diminish 'anzu-mode)
)))))


(provide 'init-anzu)
;;; init-anzu ends here
