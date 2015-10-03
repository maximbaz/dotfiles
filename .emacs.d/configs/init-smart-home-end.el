;;; package --- init-smart-home-end.el
;;;
;;; Commentary:
;;; Smart `Home' and `End'.
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name emacs-smart-home-end
   :type github
   :pkgname "z0rch/emacs-smart-home-end"
   :depends (evil)
   :features (emacs-smart-home-end)
   :after (progn
      (define-key evil-normal-state-map [home] 'emacs-smart-home)
      (define-key evil-normal-state-map [end]  'emacs-smart-end)
      (define-key evil-motion-state-map [home] 'emacs-smart-home)
      (define-key evil-motion-state-map [end]  'emacs-smart-end)
      (define-key evil-visual-state-map [home] 'emacs-smart-home)
      (define-key evil-visual-state-map [end]  'emacs-smart-end)
      (define-key evil-insert-state-map [home] 'emacs-smart-home)
      (define-key evil-insert-state-map [end]  'emacs-smart-end)
)))))


(provide 'init-smart-home-end)
;;; init-smart-home-end ends here
