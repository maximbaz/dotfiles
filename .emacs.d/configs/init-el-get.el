;;; package --- init-el-get.el
;;;
;;; Commentary:
;;; El-Get package manager
;;;
;;; Code:


;; Initialize el-get package manager
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

(el-get 'sync 'el-get)


(provide 'init-el-get)
;;; init-el-get ends here
