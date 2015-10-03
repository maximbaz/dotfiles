;;; package --- init-base.el
;;;
;;; Commentary:
;;; Base Emacs settings
;;;
;;; Code:


;; Always load newest byte code
(setq-default load-prefer-newer t)

;; Use UTF-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)
(load-library "iso-transl")

;; Reduce frequency of garbage collection to 50MB
(setq-default gc-cons-threshold 50000000)

;; Warn when open file larger than 100MB
(setq-default large-file-warning-threshold 100000000)

;; Turn off bell
(setq-default ring-bell-function 'ignore)

;; Personal information
(setq-default user-full-name "Maxim Baz")

;; Echo commands I haven't finished quicker than 0.1 second
(setq-default echo-keystrokes 0.1)

;; Set window size
(when window-system
  (set-frame-size (selected-frame) 120 24))

;; Show line numbers
(global-linum-mode t)
(column-number-mode t)
(setq-default linum-format 'dynamic)
(fringe-mode '(10 . 10))

;; Use word wrap
(global-visual-line-mode t)

;; Hide toolbar, scrollbar and menubar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Do not show startup screen
(setq-default inhibit-startup-screen t)

;; Automatically revert buffer when no local changes
(global-auto-revert-mode t)

;; Automatically save buffers before compiling
(setq-default compilation-ask-about-save nil)

;; Always ask for y/n keypress instead of typing out 'yes' or 'no'
(defalias 'yes-or-no-p 'y-or-n-p)

;; Set font
(set-frame-font "Powerline Consolas-14" nil t)

;; Enable prettify symbols mode
(global-prettify-symbols-mode t)
(add-hook 'prog-mode-hook (lambda ()
  (push '("lambda" . ?λ) prettify-symbols-alist)
  (push '("<="     . ?≤) prettify-symbols-alist)
  (push '(">="     . ?≥) prettify-symbols-alist)
))

;; Put closing bracket automatically
(electric-pair-mode)

;; Display time
(setq-default display-time-format "%a, %d %b | %I:%M%p ")
(setq-default display-time-default-load-average nil)
(display-time)

;; Show matching parenthesis
(show-paren-mode t)

;; Use spaces for identation
;; TODO: requre requred??
(require 'whitespace)
(setq-default whitespace-style '(face trailing tab-mark))
(setq-default tab-width 2)
(setq-default js-indent-level 2)
(setq-default indent-tabs-mode nil)
(global-whitespace-mode 1)
(setq-default evil-shift-width 2)

;; Dired asks only once for deleting non-empty dirs
(setq-default dired-recursive-deletes 'top)

;; Dired shows directories first
(setq-default ls-lisp-dirs-first t)

;; Dired uses better listing
(setq-default dired-listing-switches "-a")

;; WDired starts in normal mode
(add-hook 'wdired-mode-hook 'evil-normal-state)

;; Smooth scroll with margin
(setq-default
  scroll-margin                   5
  scroll-conservatively           9999
  scroll-step                     1
  mouse-wheel-scroll-amount       '(1)
  mouse-wheel-progressive-speed   nil)

;; Setup browser on Linux
(cond ((my/is-linux)
  (setq browse-url-browser-function 'browse-url-generic
        browse-url-generic-program "google-chrome")))

;; Use CYGWIN bash on Windows
(cond ((not (my/is-linux))
  (add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t)
  (add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt nil t)

  (setq shell-file-name "bash.exe")
  (setq-default explicit-shell-file-name shell-file-name)
  (setenv "SHELL" shell-file-name)

  ;; (setq binary-process-input t)
  ;; (setq w32-quote-process-args ?\")
  ;; (setq-default explicit-bash-args '("-login" "-i"))))
))

;; Store all backup and autosave files in the tmp dir
(setq-default backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq-default auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; Save all buffers without prompt
(add-hook 'find-file-hook (lambda() (setq buffer-save-without-query t)))

;; Spell check
(setq-default ispell-personal-dictionary "~/.flyspell_dict")
(setq-default ispell-program-name "aspell")
(setq-default ispell-list-command "--list")
(setq-default ispell-extra-args
  (list "--sug-mode=ultra"
        "--run-together"
        "--run-together-limit=5"
        "--run-together-min=2"))

(add-hook 'flyspell-mode-hook 'my/flyspell-diminish)
(add-hook 'flyspell-prog-mode-hook 'my/flyspell-diminish)

(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; Enable superword mode in programming modes
(add-hook 'prog-mode-hook 'superword-mode)

;; Don't disable narrowing commands
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page   'disabled nil)
(put 'narrow-to-defun  'disabled nil)

;; Dired show directories first
(setq-default dired-listing-switches "-aBhlL --group-directories-first --dereference-command-line-symlink-to-dir")

;; Don't let Ctrl-Z be remapped
(setq-default evil-toggle-key "")

;; Indent after pressing <Enter>
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Toggle fullscreen
(global-set-key [f11] 'my/toggle-fullscreen)

;; Delete trailing whitespace
(define-key global-map [f10] 'delete-trailing-whitespace)

;; Define shortcuts for modifying Emacs transparency
(global-set-key (kbd "C-<kp-7>") '(lambda() (interactive)(my/emacs-opacity-inc-dec t)))
(global-set-key (kbd "C-<kp-8>") '(lambda() (interactive)(my/emacs-opacity-inc-dec)))
(global-set-key (kbd "C-<kp-9>") '(lambda() (interactive)(modify-frame-parameters nil `((alpha . 100)))))

;; Unmap annoying hotkeys
(define-key global-map (kbd "M-l") nil)

;; Translate Russian keystrokes into English, except for text modes.
(my/translate-russian-keystrokes)
(add-hook 'text-mode-hook (lambda () (my/literal-insert-mode t)))


(provide 'init-base)
;;; init-base ends here
