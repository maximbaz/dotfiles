;;; package --- init-functions.el
;;;
;;; Commentary:
;;; Custom functions
;;;
;;; Code:


(defun my/distraction-free ()
  "Enables distraction-free mode."
  (interactive)
  (walk-windows (lambda (win)
    (let* ((new-margin (max 0 (/ (- (window-width win) 120) 2)))
           (new-linum-format (if (> new-margin 4)
                                 (concat "%" (number-to-string new-margin) "d")
                                 'dynamic)))
      (setq-default linum-format new-linum-format)
      (setq-default right-margin-width new-margin)
      (set-window-buffer win (window-buffer win))))))

(defun my/toggle-fullscreen ()
  "Toggle full screen."
  (interactive)
  (when window-system
    (let ((to-full-screen (not (frame-parameter nil 'fullscreen))))
      (set-frame-parameter nil 'fullscreen (when to-full-screen 'fullboth))
      (redisplay)
      (my/distraction-free))))

(defun my/open-line-above ()
  "Open line above."
  (interactive)
  ;; save-excursion does not preserve line if cursor is in 0 column
  (if (eq 0 (current-column)) (forward-char))
  (save-excursion
    (beginning-of-line)
    (newline)))

(defun my/open-line-below ()
  "Open line below."
  (interactive)
  (save-excursion
    (end-of-line)
    (newline)))

(defun my/edit-emacs-config ()
  "Edit Emacs config."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun my/load-emacs-config ()
  "Load Emacs config."
  (interactive)
  (load-file "~/.emacs.d/init.el"))

(defun my/evil-shift-left-visual ()
  "Shift left visual selection."
  (interactive)
  (evil-shift-left (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

(defun my/evil-shift-right-visual ()
  "Shift right visual selection."
  (interactive)
  (evil-shift-right (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

(defun my/minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq-default deactivate-mark        t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))

(defun my/flyspell-diminish ()
  "Hook flyspell initialization and diminish it."
  (eval-after-load 'diminish '(diminish 'flyspell-mode)))

(defun my/flyspell-add-word-to-dict ()
  "Add the word at the current location to the private dictionary without question."
  (interactive)
  ;; Use the correct dictionary.
  (flyspell-accept-buffer-local-defs)
  (setq opoint (point-marker))
  (let ((cursor-location (point))
        (word (flyspell-get-word nil)))
    (if (consp word)
        (let ((start (car (cdr word)))
              (end (car (cdr (cdr word))))
              (word (car word)))
          ;; The word is incorrect, we have to propose a replacement.
          (flyspell-do-correct 'save nil word cursor-location start end opoint)))
    (ispell-pdict-save t)))

(defun my/eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(defun my/emacs-opacity-inc-dec (&optional dec)
  "Modify the transparency of the Emacs frame.
If DEC is t, decrease the transparency, otherwise increase it in 10%-steps"
  (let* ((alpha-or-nil (frame-parameter nil 'alpha)) ; nil before setting
          (oldalpha (if alpha-or-nil alpha-or-nil 100))
          (newalpha (if dec (- oldalpha 15) (+ oldalpha 15))))
    (when (and (>= newalpha frame-alpha-lower-limit) (<= newalpha 100))
      (modify-frame-parameters nil (list (cons 'alpha newalpha))))))

(defun my/is-linux ()
  "Check if current OS is Linux."
  (eq system-type 'gnu/linux))

(defun my/evil-select-all ()
  "Enter visual mode and select entire buffer."
  (interactive)
  (evil-goto-first-line)
  (evil-visual-line)
  (evil-goto-line))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Translate Russian keystrokes into English
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my/translate-russian-keystrokes ()
  "Make Emacs output English characters, regardless whether the OS keyboard is English or Russian."
  (cl-flet ((make-key-stroke (prefix char)
                          (eval `(kbd ,(if (and (string-match "^C-" prefix)
                                                (string-match "[A-Z]" (string char)))
                                           (concat "S-" prefix (string (downcase char)))
                                         (concat prefix (string char)))))))
    (let ((case-fold-search nil)
          (keys-pairs (mapcar* 'cons
                               "йцукенгшщзхъфывапролджэячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖ\ЭЯЧСМИТЬБЮ№"
                               "qwertyuiop[]asdfghjkl;'zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>#"))
          (prefixes '(""    "s-"    "M-"    "M-s-"
                      "C-"  "C-s-"  "C-M-"  "C-M-s-")))
      (mapc (lambda (prefix)
              (mapc (lambda (pair)
                      (define-key key-translation-map
                        (make-key-stroke prefix (car pair))
                        (make-key-stroke prefix (cdr pair))))
                    keys-pairs))
            prefixes))))

(defun my/literal-insert ()
  "Insert literal as it was typed, without translating it to English keystroke."
  (interactive)
  (insert-char last-input-event 1))

(define-minor-mode my/literal-insert-mode
  "Make Emacs output characters corresponging to the OS keyboard, ignoring the key-translation-map."
  :keymap (let ((new-map (make-sparse-keymap))
                (english-chars "qwertyuiop[]asdfghjkl;'zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>#"))
            (mapc (lambda (char)
                    (define-key new-map (string char)
                      'my/literal-insert))
                  english-chars)
            new-map))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Easter
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my/gregorian-easter (year)
  "Calculate the date for Easter Sunday in YEAR.
Return the date in the Gregorian calendar, ie (MM DD YY) format."
  (let* ((century (1+ (/ year 100)))
         (shifted-epact (% (+ 14 (* 11 (% year 19))
                              (- (/ (* 3 century) 4))
                              (/ (+ 5 (* 8 century)) 25)
                              (* 30 century))
                           30))
         (adjusted-epact (if (or (= shifted-epact 0)
                                 (and (= shifted-epact 1)
                                      (< 10 (% year 19))))
                             (1+ shifted-epact)
                           shifted-epact))
         (paschal-moon (- (calendar-absolute-from-gregorian
                           (list 4 19 year))
                          adjusted-epact)))
    (calendar-dayname-on-or-before 0 (+ paschal-moon 7))))

(defun my/calendar-days-from-easter ()
  "When used in a diary sexp, this function will calculate how many days are between the current date (DATE) and Easter Sunday."
  (- (calendar-absolute-from-gregorian date)
     (my/gregorian-easter (calendar-extract-year date))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     Org Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my/org-mark-next-projects-as-todo ()
  "NEXT keyword is for tasks, not projects, so mark NEXT project as TODO instead."
  (let ((mystate (or (and (fboundp 'org-state)
                          state)
                     (nth 2 (org-heading-components)))))
    (when mystate
      (save-excursion
        (while (org-up-heading-safe)
          (when (member (nth 2 (org-heading-components)) (list "NEXT"))
            (org-todo "TODO")))))))

(defun my/org-metaleft-visual ()
  "Keep visual selection after `org-metaleft`."
  (interactive)
  (org-metaleft)
  (evil-normal-state)
  (evil-visual-restore))

(defun my/org-metaright-visual ()
  "Keep visual selection after `org-metaright`."
  (interactive)
  (org-metaright)
  (evil-normal-state)
  (evil-visual-restore))

(defun my/org-metaup-visual ()
  "Keep visual selection after `org-metaup`."
  (interactive)
  (org-metaup)
  (evil-normal-state)
  (evil-visual-restore))

(defun my/org-metadown-visual ()
  "Keep visual selection after `org-metadown`."
  (interactive)
  (org-metadown)
  (evil-normal-state)
  (evil-visual-restore))

(defun my/org-shiftmetaleft-visual ()
  "Keep visual selection after `org-shiftmetaleft`."
  (interactive)
  (org-shiftmetaleft)
  (evil-normal-state)
  (evil-visual-restore))

(defun my/org-shiftmetaright-visual ()
  "Keep visual selection after `org-shiftmetaright`."
  (interactive)
  (org-shiftmetaright)
  (evil-normal-state)
  (evil-visual-restore))

(defun my/org-shiftmetaup-visual ()
  "Keep visual selection after `org-shiftmetaup`."
  (interactive)
  (org-shiftmetaup)
  (evil-normal-state)
  (evil-visual-restore))

(defun my/org-shiftmetadown-visual ()
  "Keep visual selection after `org-shiftmetadown`."
  (interactive)
  (org-shiftmetadown)
  (evil-normal-state)
  (evil-visual-restore))

(defun my/org-insert-heading-after-current ()
  "Insert heading after current line and enter Insert mode."
  (interactive)
  (org-insert-heading-after-current)
  (evil-insert-state))

(defun my/org-insert-todo-heading-after-current ()
  "Insert TODO after current line and enter Insert mode."
  (interactive)
  (evil-append-line 1)
  (command-execute (kbd "C-u M-S-<return>")))

(defun my/org-find-project-task ()
  "Move point to the parent (project) task if any."
  (save-restriction
    (widen)
    (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
      (while (org-up-heading-safe)
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
          (setq parent-task (point))))
      (goto-char parent-task)
      parent-task)))

(defun my/org-is-project-p ()
  "Any task with a todo keyword subtask is a project."
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task has-subtask))))

(defun my/org-is-project-subtree-p ()
  "Any task with a todo keyword that is in a project subtree.
Callers of this function already widen the buffer view."
  (let ((task (save-excursion (org-back-to-heading 'invisible-ok)
                              (point))))
    (save-excursion
      (my/org-find-project-task)
      (if (equal (point) task) nil t))))

(defun my/org-is-task-p ()
  "Any task with a todo keyword and no subtask."
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task (not has-subtask)))))

(defun my/org-skip-non-stuck-projects ()
  "Skip trees that are not stuck projects."
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (my/org-is-project-p)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                 (has-next ))
            (save-excursion
              (forward-line 1)
              (while (and (not has-next)
                          (< (point) subtree-end)
                          (re-search-forward "^\\*+ NEXT " subtree-end t))
                (unless (member "WAITING" (org-get-tags-at))
                  (setq has-next t))))
            (save-excursion
              (forward-line 1)
              (while (and (not has-next)
                          (< (point) subtree-end)
                          (re-search-forward "^\\*+ TODO " subtree-end t))
                (unless (eq (org-get-scheduled-time (point)) nil)
                  (setq has-next t))))
            (if has-next
                next-headline
              nil)) ; KEEP a stuck project, that has subtasks but no NEXT or scheduled task
        next-headline))))

(defun my/org-skip-non-stuck-standalone-tasks ()
  "Skip trees that are not stuck standalone tasks."
  (save-restriction
    (widen)
    (let* ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (and (my/org-is-task-p)
               (not (my/org-is-project-subtree-p))
               (eq (org-get-scheduled-time (point)) nil))
          nil ;; KEEP a stuck task, that is TODO and not scheduled
          next-headline))))

(defun my/org-skip-non-forgotten-tasks ()
  "Skip trees that are not forgotten tasks."
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (my/org-is-task-p)
        (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
               (last-timestamp))
          (save-excursion
            (when (re-search-forward (org-re-timestamp 'inactive) subtree-end t)
              (setq last-timestamp (org-time-string-to-time (match-string 1)))))
          (if (or (eq nil last-timestamp)
                  (time-less-p last-timestamp (time-subtract (current-time) (days-to-time 14))))
              nil ;; KEEP a forgotten task, that has been untouched for more than 14 days in NEXT state
              next-headline))
        next-headline))))

(defvar my/org-agenda-is-filtered nil)

(defun my/org-skip-forgotten-tasks ()
  "Skip trees that are forgotten tasks."
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (my/org-is-task-p)
          (if (and (not my/org-agenda-is-filtered)
                   (member (org-get-todo-state) (list "TODO")))
              next-headline ;; SKIP TODO tasks unless agenda is filtered
            (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                   (last-timestamp))
              (save-excursion
                (when (re-search-forward (org-re-timestamp 'inactive) subtree-end t)
                  (setq last-timestamp (org-time-string-to-time (match-string 1)))))
              (if (or (eq nil last-timestamp)
                      (time-less-p last-timestamp (time-subtract (current-time) (days-to-time 14))))
                  next-headline ;; SKIP a forgotten task, that has been untouched for more than 14 days in NEXT state
                nil)))
        next-headline))))

(defun my/org-skip-non-projects ()
  "Skip trees that are not projects."
  (if (save-excursion (my/org-skip-non-stuck-projects))
      (save-restriction
        (widen)
        (let ((subtree-end (save-excursion (org-end-of-subtree t))))
          (cond
           ((my/org-is-project-p) nil)
           ((and (my/org-is-project-subtree-p) (not (my/org-is-task-p))) nil)
           (t subtree-end))))
    (save-excursion (org-end-of-subtree t))))

(defun my/org-skip-non-archivable-tasks ()
  "Skip trees that are not available for archiving."
  (save-restriction
    (widen)
    (let* ((next-headline (save-excursion (or (outline-next-heading) (point-max))))
           (subtree-end (save-excursion (org-end-of-subtree t)))
           (daynr (string-to-number (format-time-string "%d" (current-time))))
           (a-month-ago (* 60 60 24 (+ daynr 1)))
           (last-month (format-time-string "%Y-%m-" (time-subtract (current-time) (seconds-to-time a-month-ago))))
           (this-month (format-time-string "%Y-%m-" (current-time)))
           (subtree-is-current (save-excursion
                                 (forward-line 1)
                                 (and (< (point) subtree-end)
                                      (re-search-forward (concat last-month "\\|" this-month) subtree-end t)))))
        (if subtree-is-current
            next-headline ; Has a date in this month or last month, skip it
          nil))))  ; available to archive

(defun my/org-insert-inactive-timestamp ()
  "Insert inactive timestamp."
  (interactive)
  (org-insert-time-stamp nil t t nil nil nil))

(defun my/org-insert-heading-inactive-timestamp ()
  (save-excursion
    (org-return)
    (org-cycle)
    (my/org-insert-inactive-timestamp)))

(defun my/org-verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets."
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(defvar my/org-keep-clock-running t)

(defun my/org-punch-in (arg)
  "Start continuous clocking and set the default task to the
selected task.  If no task is selected set the Organization task
as the default task."
  (interactive "p")
  (setq my/org-keep-clock-running t)
  (if (equal major-mode 'org-agenda-mode)
      ;;
      ;; We're in the agenda
      ;;
      (let* ((marker (org-get-at-bol 'org-hd-marker))
             (tags (org-with-point-at marker (org-get-tags-at))))
        (if (and (eq arg 4) tags)
            (org-agenda-clock-in '(16))
          (my/org-clock-in-organization-task-as-default)))
    ;;
    ;; We are not in the agenda
    ;;
    (save-restriction
      (widen)
      ; Find the tags on the current task
      (if (and (equal major-mode 'org-mode) (not (org-before-first-heading-p)) (eq arg 4))
          (org-clock-in '(16))
        (my/org-clock-in-organization-task-as-default)))))

(defun my/org-punch-out ()
  (interactive)
  (setq my/org-keep-clock-running nil)
  (when (org-clock-is-active)
    (org-clock-out))
  (org-agenda-remove-restriction-lock))

(defvar my/org-organization-task-id "62b8dcea-9f4f-4fdb-96db-c8cf1089bc77")

(defun my/org-clock-in-organization-task-as-default ()
  (interactive)
  (org-with-point-at (org-id-find my/org-organization-task-id 'marker)
    (org-clock-in '(16))))

(defun my/org-clock-in-default-task ()
  (save-excursion
    (org-with-point-at org-clock-default-task
      (org-clock-in))))

(defun my/org-clock-in-parent-task ()
  "Move point to the parent (project) task if any and clock in."
  (let ((parent-task))
    (save-excursion
      (save-restriction
        (widen)
        (while (and (not parent-task) (org-up-heading-safe))
          (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
            (setq parent-task (point))))
        (if parent-task
            (org-with-point-at parent-task
              (org-clock-in))
          (when my/org-keep-clock-running
            (my/org-clock-in-default-task)))))))

(defun my/org-clock-out-maybe ()
  (when (and my/org-keep-clock-running
             (not org-clock-clocking-in)
             (marker-buffer org-clock-default-task)
             (not org-clock-resolving-clocks-due-to-idleness))
    (my/org-clock-in-parent-task)))

(defun my/org-clock-in-last-task (arg)
  "Clock in the interrupted task if there is one.
Skip the default task and get the next one.
A prefix arg forces clock in of the default task."
  (interactive "p")
  (let ((clock-in-to-task
         (cond
          ((eq arg 4) org-clock-default-task)
          ((and (org-clock-is-active)
                (equal org-clock-default-task (cadr org-clock-history)))
           (caddr org-clock-history))
          ((org-clock-is-active) (cadr org-clock-history))
          ((equal org-clock-default-task (car org-clock-history)) (cadr org-clock-history))
          (t (car org-clock-history)))))
    (widen)
    (org-with-point-at clock-in-to-task
      (org-clock-in nil))))

(defun my/org-clock-out-after-codereview ()
  "Clock out automatically if the task is moved to CODEREVIEW state."
  (when (and (member (org-get-todo-state) (list "CODEREVIEW")) (org-clock-is-active))
    (org-clock-out)))

(defun my/org-agenda-filter-by-category ()
  "Filter by category and rebuild the agenda."
  (interactive)
  (command-execute 'org-agenda-filter-by-category)
  (setq my/org-agenda-is-filtered org-agenda-category-filter)
  (org-agenda-redo))

(defadvice org-agenda-add-time-grid-maybe (around mde-org-agenda-grid-tweakify
                                            (list ndays todayp))
  "Skip occupied lines in time grid."

  (defun org-time-to-minutes (time)
    "Convert an HHMM TIME to minutes."
    (+ (* (/ time 100) 60) (% time 100)))

  (defun org-time-from-minutes (minutes)
    "Convert a number of MINUTES to an HHMM time."
    (+ (* (/ minutes 60) 100) (% minutes 60)))

  (if (member 'remove-match (car org-agenda-time-grid))
    (flet ((extract-window
      (line)
      (let ((start (get-text-property 1 'time-of-day line))
            (dur (get-text-property 1 'duration line)))
        (cond
         ((and start dur)
          (cons start
                (org-time-from-minutes
                (+ dur (org-time-to-minutes start)))))
         (start start)
         (t nil)))))
      (let* ((windows (delq nil (mapcar 'extract-window list)))
             (org-agenda-time-grid
              (list (car org-agenda-time-grid)
                    (cadr org-agenda-time-grid)
                    (remove-if
                     (lambda (time)
                       (find-if (lambda (w)
                                  (if (numberp w)
                                      (equal w time)
                                    (and (>= time (car w))
                                         (< time (cdr w)))))
                                windows))
                     (caddr org-agenda-time-grid)))))
        ad-do-it))
    ad-do-it))


(provide 'init-functions)
;;; init-functions ends here
