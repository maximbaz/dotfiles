;;; package --- init-smart-mode-line.el
;;;
;;; Commentary:
;;; Smart Mode Line
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name smart-mode-line
   :after (progn
      (setq sml/col-number-format "%c")
      (sml/setup)
      (sml/apply-theme 'respectful)

      (add-to-list 'sml/replacer-regexp-list '("^~/"           ":~:") t)
      (add-to-list 'sml/replacer-regexp-list '("^:~:Dropbox/"  ":~db:") t)
      (add-to-list 'sml/replacer-regexp-list '("^:~:dotfiles/" ":~df:") t)
)))))


(provide 'init-smart-mode-line)
;;; init-smart-mode-line ends here
