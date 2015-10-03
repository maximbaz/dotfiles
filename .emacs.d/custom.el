;;; package --- custom.el
;;;
;;; Commentary:
;;; Custom Emacs settings
;;;
;;; Code:


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bd19fec77fa640b63cbf22f8328222b3dc4c8f891f63be6ea861187bc6c6c4e4" "fa3d1eb84f00ff9f62f13e788063a0bdb9862b4dfcd2263066cd567c11f052db" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "c5a044ba03d43a725bd79700087dea813abcb6beb6be08c7eb3303ed90782482" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "91562815ddc291827d019ef03748932c500dc2c0969ec9930e1dd97782610e66" "96ec5305ec9f275f61c25341363081df286d616a27a69904a35c9309cfa0fe1b" "c5a044ba03d43a725bd79700087dea813abcb6beb6be08c7eb3303ed90782482" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" default)))
 '(package-selected-packages (quote (evil)))
 '(send-mail-function (quote smtpmail-send-it)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(col-highlight ((nil :background "#343434")))
 '(linum ((t (:background "#3F3F3F" :foreground "#9FC59F" :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal))))
 '(org-mode-line-clock ((t (:background "#343434" :foreground "#85a485" :box (:line-width -1 :style released-button)))))
 '(org-mode-line-clock-overrun ((t (:background "#343434" :foreground "#F84A1C" :box (:line-width -1 :style released-button))))))


(provide 'custom)
;;; custom ends here
