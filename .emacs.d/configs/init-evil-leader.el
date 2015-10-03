;;; package --- init-evil-leader.el
;;;
;;; Commentary:
;;; Evil Leader
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name evil-leader
   :after (progn
      (global-evil-leader-mode)
      (provide 'my/evil-initialized)

      (evil-leader/set-leader "<SPC>")
      (evil-leader/set-key
        "b"     'helm-mini
        "ee"    'eval-last-sexp
        "er"    'my/eval-and-replace
        "ec"    'my/edit-emacs-config
        "cc"    'kill-this-buffer
        "cr"    'comment-or-uncomment-region
        "h"     'helm-apropos
        "nf"    'narrow-to-defun
        "nr"    'narrow-to-region
        "nw"    'widen
        "P"     'el-get-list-packages
        "r"     'helm-resume
        "v"     'my/evil-select-all
        "w"     'save-buffer
        "qq"    'save-buffers-kill-terminal
      )
)))))


(provide 'init-evil-leader)
;;; init-evil-leader ends here
