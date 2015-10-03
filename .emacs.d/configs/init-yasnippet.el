;;; package --- init-yasnippet.el
;;;
;;; Commentary:
;;; YaSnippet
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name yasnippet
   :after (progn
      (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
      (yas-global-mode t)

      (diminish 'yas-minor-mode)
)))))


(provide 'init-yasnippet)
;;; init-yasnippet ends here
