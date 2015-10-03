;;; package --- init-evil.el
;;;
;;; Commentary:
;;; Evil mode
;;;
;;; Code:


;; TODO: Cannot build evil on Windows
(cond
  ((my/is-linux)
    (setq el-get-sources (append el-get-sources '(
      (:name evil
       :after (evil-mode-post-load)
  )))))
  (t
    (setq el-get-sources (append el-get-sources '(
      (:name evil
       :type elpa
       :after (evil-mode-post-load)
  )))))
)


(defmacro evil-mode-post-load (&rest body)
  `((lambda ()
      (with-eval-after-load 'my/evil-initialized
        (evil-mode t)

        ;; Don't use system clipboard by default
        (if (my/is-linux)
          (setq-default
            interprogram-cut-function   nil
            interprogram-paste-function nil
            x-select-enable-clipboard   nil))

        ;; Change cursor color depending on a mode
        (setq-default evil-emacs-state-cursor '("red" box))
        (setq-default evil-normal-state-cursor '("green" box))
        (setq-default evil-visual-state-cursor '("orange" box))
        (setq-default evil-insert-state-cursor '("red" bar))
        (setq-default evil-replace-state-cursor '("red" bar))
        (setq-default evil-operator-state-cursor '("red" hollow))

        ;; Move by display lines
        (define-key evil-motion-state-map "j" 'evil-next-visual-line)
        (define-key evil-motion-state-map "k" 'evil-previous-visual-line)

        ;; Better ZZ
        (define-key evil-normal-state-map "ZZ" 'kill-buffer-and-window)

        ;; Unmap minus and K
        (define-key evil-motion-state-map "-" nil)
        (define-key evil-normal-state-map "K" nil)

        ;; Insert empty lines in normal mode
        (define-key evil-normal-state-map (kbd "C-S-k") 'my/open-line-above)
        (define-key evil-normal-state-map (kbd "C-S-j") 'my/open-line-below)

        ;; Shift text
        (define-key evil-normal-state-map [tab]           'evil-shift-right-line)
        (define-key evil-normal-state-map [S-iso-lefttab] 'evil-shift-left-line)
        (define-key evil-normal-state-map [S-tab]         'evil-shift-left-line)
        (define-key evil-normal-state-map [backtab]       'evil-shift-left-line)

        (define-key evil-insert-state-map [tab]           'evil-shift-right-line)
        (define-key evil-insert-state-map [S-iso-lefttab] 'evil-shift-left-line)
        (define-key evil-insert-state-map [S-tab]         'evil-shift-left-line)
        (define-key evil-insert-state-map [backtab]       'evil-shift-left-line)

        (define-key evil-visual-state-map (kbd ">")       'my/evil-shift-right-visual)
        (define-key evil-visual-state-map [tab]           'my/evil-shift-right-visual)
        (define-key evil-visual-state-map (kbd "<")       'my/evil-shift-left-visual)
        (define-key evil-visual-state-map [S-iso-lefttab] 'my/evil-shift-left-visual)
        (define-key evil-visual-state-map [S-tab]         'my/evil-shift-left-visual)
        (define-key evil-visual-state-map [backtab]       'my/evil-shift-left-visual)

        ;; ESC as C-g
        (define-key evil-normal-state-map [escape] 'keyboard-quit)
        (define-key evil-visual-state-map [escape] 'keyboard-quit)
        (define-key minibuffer-local-map [escape] 'my/minibuffer-keyboard-quit)
        (define-key minibuffer-local-ns-map [escape] 'my/minibuffer-keyboard-quit)
        (define-key minibuffer-local-completion-map [escape] 'my/minibuffer-keyboard-quit)
        (define-key minibuffer-local-must-match-map [escape] 'my/minibuffer-keyboard-quit)
        (define-key minibuffer-local-isearch-map [escape] 'my/minibuffer-keyboard-quit)
        (global-set-key [escape] 'evil-exit-emacs-state)

        ;; ESC as q
        (define-key evil-motion-state-map [escape]
          (lambda () (interactive) (if (not (evil-operator-state-p)) (quit-window))))

        ;; Y to copy to the end of a line
        (define-key evil-normal-state-map "Y" "y$")

        ;; Navigate between splits
        (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
        (define-key evil-motion-state-map (kbd "C-h") 'evil-window-left)
        (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
        (define-key evil-motion-state-map (kbd "C-j") 'evil-window-down)
        (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
        (define-key evil-motion-state-map (kbd "C-k") 'evil-window-up)
        (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
        (define-key evil-motion-state-map (kbd "C-l") 'evil-window-right)

        ;; Make all modes start in evil state
        (setq evil-motion-state-modes (append evil-emacs-state-modes evil-motion-state-modes))
        (setq evil-emacs-state-modes nil)

        ;; Redo
        (define-key evil-normal-state-map "U" 'redo)

        ;; Dired
        (evil-define-key 'normal dired-mode-map
          "gg" 'evil-goto-first-line
          "G"  'evil-goto-line
          "f"  'evil-find-char
          "F"  'evil-find-char-backward
          "w"  'evil-forward-word
          "B"  'evil-backward-WORD-begin
          "e"  'evil-forward-word-end
          "n"  'evil-search-next
          "N"  'evil-search-previous
          "R"  'dired-toggle-read-only
          "o"  'dired-find-file
        )

        (evil-define-key 'normal wdired-mode-map
          "R" 'wdired-finish-edit
          "Q" 'wdired-abort-changes
        )
))))


(provide 'init-evil)
;;; init-evil ends here
