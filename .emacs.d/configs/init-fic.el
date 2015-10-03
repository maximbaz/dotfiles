;;; package --- init-fic.el
;;;
;;; Commentary:
;;; TODO and FIXME in comments and docstrings
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name fic-mode
   :features (fic-mode)
   :after (progn
      ;; Don't highlight TODOs in strings
      (delete 'font-lock-string-face fic-activated-faces)

      ;; Comply faces with the theme I use.
      (set-face-background 'fic-face "#3f3f3f")
      (set-face-background 'fic-author-face "#3f3f3f")
      (set-face-foreground 'fic-face "#F84A1C")

      (add-hook 'prog-mode-hook 'fic-mode)
)))))


(provide 'init-fic)
;;; init-fic ends here
