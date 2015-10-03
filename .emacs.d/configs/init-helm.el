;;; package --- init-helm.el
;;;
;;; Commentary:
;;; Helm (fuzzy search on everything)
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name helm
   :after (progn
      (helm-mode 1)

      ;; Enable quick update
      (setq helm-quick-update t)

      ;; Enable fuzzy match
      (setq helm-M-x-fuzzy-match t)
      (setq helm-apropos-fuzzy-match t)
      (setq helm-bookmark-show-location t)
      (setq helm-buffers-fuzzy-matching t)
      (setq helm-file-cache-fuzzy-match t)
      (setq helm-imenu-fuzzy-match t)
      (setq helm-lisp-fuzzy-completion t)
      (setq helm-locate-fuzzy-match t)
      (setq helm-recentf-fuzzy-match t)
      (setq helm-semantic-fuzzy-match t)

      (global-set-key (kbd "M-x") 'helm-M-x)

      (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
      (define-key helm-map (kbd "C-i")   'helm-execute-persistent-action) ; make TAB work in terminal
      (define-key helm-map (kbd "C-z")   'helm-select-action)             ; list actions using C-z

      (when (executable-find "curl")
        (setq helm-google-suggest-use-curl-p t))

      (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
            helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
            helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
            helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
            helm-ff-file-name-history-use-recentf t)

      (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

      (diminish 'helm-mode)

      (evil-leader/set-key
        "b"    'helm-buffers-list
        "G"    'helm-do-grep
        "f"    'helm-find-files)
)))))


(provide 'init-helm)
;;; init-helm ends here
