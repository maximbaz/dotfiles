;;; package --- init-org-mode.el
;;;
;;; Commentary:
;;; Org-Mode configuration
;;;
;;; Code:


(setq el-get-sources (append el-get-sources '(
  (:name org-mode
   :build ("make all")
   :depends (evil evil-leader)
   :after (org-mode-post-load)
))))


(defmacro org-mode-post-load (&rest body)
  `((lambda ()
      (require 'org-checklist)
      (require 'org-habit)
      (require 'org-drill)

      ;; Return follows links
      (setq-default org-return-follows-link t)

      ;; Put timestamp when task is completed
      (setq-default org-log-done 'time)

      ;; Indent headers visually
      (setq-default org-startup-indented t)

      ;; Startup in folded view
      (setq-default org-startup-folded t)

      ;; Catch invisible edits
      (setq-default org-catch-invisible-edits 'error)

      ;; Default mode-line clock to today
      (setq-default org-clock-mode-line-total 'today)

      ;; Allow alphabetical list entries
      (setq-default org-alphabetical-lists t)

      ;; Hide blank lines in folded view
      (setq-default org-cycle-separator-lines 0)

      ;; Warn about deadlines earlier
      (setq-default org-deadline-warning-days 30)

      ;; Hide SCHEDULED and DEADLINE items when done
      (setq-default org-agenda-skip-scheduled-if-done t)
      (setq-default org-agenda-skip-deadline-if-done t)

      ;; Don't show DEADLINE prewarning prior to the SCHEDULED date
      (setq-default org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)

      ;; Enable persistent filter
      (setq-default org-agenda-persistent-filter t)

      ;; Resume clocking task when Emacs is restarted
      (org-clock-persistence-insinuate)

      ;; Save the running clock and clock history when Emacs is restarted
      (setq-default org-clock-persist t)

      ;; Don't prompt to resume an active clock
      (setq-default org-clock-persist-query-resume nil)

      ;; Resume clocking task on clock-in if the clock is open
      (setq-default org-clock-in-resume t)

      ;; Show larger clocking history
      (setq-default org-clock-history-length 20)

      ;; Save clock data and state changes and notes in the LOGBOOK drawer
      (setq-default org-clock-into-drawer t)
      (setq-default org-log-into-drawer t)

      ;; Remove 0:00 clocks
      (setq-default org-clock-out-remove-zero-time-clocks t)

      ;; Clock out when done
      (setq-default org-clock-out-when-done t)

      ;; Also clock out when changing to CODEREVIEW state
      (add-hook 'org-after-todo-state-change-hook 'my/org-clock-out-after-codereview)

      ;; Include current clocking task in clock reports
      (setq-default org-clock-report-include-clocking-task t)

      ;; Setup column view
      (setq-default org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")

      ;; Don't round minutes with S-<up> and S-<down>
      (setq-default org-time-stamp-rounding-minutes '(1 1))

      ;; Skip occupied lines in time grid
      (setq-default org-agenda-time-grid
        '((daily today remove-match)
        #("----------------" 0 16 (org-heading t))
        (0900 1100 1300 1500 1700)))

      (ad-activate 'org-agenda-add-time-grid-maybe)

      ;; Use full path for refile locations
      (setq-default org-refile-use-outline-path t)
      (setq-default org-outline-path-complete-in-steps nil)

      ;; Exclude DONE state tasks from refile targets
      (setq-default org-refile-target-verify-function 'my/org-verify-refile-target)

      ;; Display tags farther right
      (setq org-agenda-tags-column -102)

      ;; Dynamic separator doesn't work with line numbers
      (setq-default org-agenda-block-separator "====================================================================")

      ;; Keep clock duration in hours
      (setq org-time-clocksum-format
        '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))

      ;; Setup Org directories location
      (setq-default org-directory "~/Org")
      (setq-default org-agenda-files (list "~/Org"))
      (setq-default org-refile-targets '(("~/Org/todo.org" :maxlevel . 9)
                                         ("~/Org/microsoft.org" :maxlevel . 9)))

      ;; Default notes location
      (setq-default org-default-notes-file "~/Org/refile.org")

      ;; Default archive location
      (setq-default org-archive-location "~/Org/archive/%s::* Archive")

      ;; Use one day agenda view by default
      (setq-default org-agenda-span 'day)

      ;; Don't change status of task when archived
      (setq-default org-archive-mark-done nil)

      ;; Add TODO statements
      (setq-default org-todo-keywords '(
        (sequence "TODO(t)" "NEXT(n!)" "|" "DONE(d)")
        (sequence "WAITING(w!/!)" "CODEREVIEW(r!/!)" "HOLD(h!/!)" "|" "CANCELLED(c!/!)")))

      ;; Colorize TODO statements
      (setq org-todo-keyword-faces '(
        ("TODO"        :foreground "#F84A1C" :weight bold)
        ("NEXT"        :foreground "#E9B600" :weight bold)
        ("DONE"        :foreground "#58DE58" :weight bold)
        ("WAITING"     :foreground "#F056F0" :weight bold)
        ("CODEREVIEW"  :foreground "#F056F0" :weight bold)
        ("HOLD"        :foreground "#A945FF" :weight bold)
        ("CANCELLED"   :foreground "#42D6EC" :weight bold)
        ("MEETING"     :foreground "#58DE58" :weight bold)))


      ;; TODO state triggers tags assignments
      (setq-default org-todo-state-tags-triggers '(
        ("TODO"          ("WAITING")     ("CODEREVIEW")     ("CANCELLED")     ("HOLD"))
        ("NEXT"          ("WAITING")     ("CODEREVIEW")     ("CANCELLED")     ("HOLD"))
        ("DONE"          ("WAITING")     ("CODEREVIEW")     ("CANCELLED")     ("HOLD"))
        ("WAITING"       ("WAITING" . t) ("CODEREVIEW")     ("CANCELLED")     ("HOLD"))
        ("CODEREVIEW"    ("WAITING")     ("CODEREVIEW" . t) ("CANCELLED")     ("HOLD"))
        ("HOLD"          ("WAITING")     ("CODEREVIEW")     ("CANCELLED")     ("HOLD" . t))
        ("CANCELLED"     ("WAITING")     ("CODEREVIEW")     ("CANCELLED" . t) ("HOLD"))
      ))

      ;; Capture templates
      (setq-default org-capture-templates '(
        ("t" "Todo" entry (file "~/Org/refile.org")
         "* TODO %?\n%U\n" :clock-in t :clock-resume t)
        ("m" "Meeting" entry (file "~/Org/refile.org")
         "* TODO %? :MEETING:\n%U\n" :clock-in t :clock-resume t)
        ("n" "Note" entry (file "~/Org/refile.org")
         "* %? :NOTE:\n%U\n" :clock-in t :clock-resume t)
      ))

      ;; Custom agenda command definitions
      (setq org-agenda-custom-commands '(
        ("n" "Notes" tags "NOTE"
          ((org-agenda-overriding-header "Notes")
           (org-tags-match-list-sublevels t)))

        ("h" "Habits" tags-todo "STYLE=\"habit\""
         ((org-agenda-overriding-header "Habits")
          (org-agenda-sorting-strategy
           '(todo-state-down effort-up category-keep))))

        (" " "Agenda"
         ((agenda "" nil)

          (tags-todo "+PIN-REFILE/!"
            ((org-agenda-overriding-header "Pinned items")
             (org-tags-match-list-sublevels nil)))

          (tags "REFILE"
            ((org-agenda-overriding-header "Tasks to Refile")
             (org-tags-match-list-sublevels nil)))

          (tags-todo "-REFILE-PIN-WAITING-HOLD-CODEREVIEW/!"
            ((org-agenda-overriding-header "Stuck Projects")
             (org-agenda-skip-function 'my/org-skip-non-stuck-projects)
             (org-agenda-sorting-strategy '(category-keep))))

          (tags-todo "-REFILE-PIN/!+TODO"
            ((org-agenda-overriding-header "Stuck Standalone Tasks")
             (org-agenda-skip-function 'my/org-skip-non-stuck-standalone-tasks)
             (org-agenda-sorting-strategy '(category-keep))))

          (tags-todo "-REFILE-PIN/!+NEXT"
            ((org-agenda-overriding-header "Forgotten Tasks")
             (org-agenda-skip-function 'my/org-skip-non-forgotten-tasks)
             (org-agenda-sorting-strategy '(category-keep))))

          (tags-todo "-REFILE-PIN/!"
            ((org-agenda-overriding-header "Projects")
             (org-agenda-skip-function 'my/org-skip-non-projects)
             (org-agenda-sorting-strategy '(category-keep))))

          (tags-todo "-REFILE-PIN/!+NEXT|TODO"
            ((org-agenda-overriding-header "Next Tasks")
             (org-agenda-skip-function 'my/org-skip-forgotten-tasks)
             (org-agenda-sorting-strategy '(category-keep))))

          (tags-todo "/!+WAITING|HOLD|CODEREVIEW"
            ((org-agenda-overriding-header "Waiting and Postponed Tasks")
             (org-agenda-sorting-strategy '(todo-state-up))
             (org-tags-match-list-sublevels nil)))

          (todo "DONE|CANCELLED"
            ((org-agenda-overriding-header "Tasks to Archive")
             (org-agenda-skip-function 'my/org-skip-non-archivable-tasks))
             (org-tags-match-list-sublevels nil)))

         nil)))

      ;; Hook clock out to continue running the clock towards parent TODO or Organization
      (add-hook 'org-clock-out-hook 'my/org-clock-out-maybe 'append)

      ;; Org-capture starts in insert mode
      (add-hook 'org-capture-mode-hook 'evil-insert-state)

      ;; Capture NEXT tasks, that became projects, and change them to TODO
      (add-hook 'org-after-todo-state-change-hook 'my/org-mark-next-projects-as-todo 'append)
      (add-hook 'org-clock-in-hook 'my/org-mark-next-projects-as-todo 'append)

      ;; Insert inactive timestamp when creating a new heading
      (add-hook 'org-insert-heading-hook 'my/org-insert-heading-inactive-timestamp 'append)

      ;; Auto save all org buffers
      (add-hook 'auto-save-hook 'org-save-all-org-buffers)

      ;; Define global Org-mode hotkeys
      (evil-leader/set-key
        "oI" 'my/org-punch-in
        "oO" 'my/org-punch-out
        "oc" 'org-capture
        "of" 'org-iswitchb
        "oa" 'org-agenda
        "oe" 'org-clock-modify-effort-estimate
        "okj" 'org-clock-goto
        "oko" 'org-clock-out
        "okl" 'my/org-clock-in-last-task
      )

      ;; Cannot emulate in leader key, keep here to see if used
      (global-set-key (kbd "C-c C-l") 'org-clock-in)

      ;; Define some Org-mode specific hotkeys
      (evil-define-key 'normal org-mode-map
        "t"            'org-todo
        "T"            'org-todo-yesterday
        "m"            'org-cycle
        "M"            'org-global-cycle
        "-"            'org-cycle-list-bullet
        "="            'org-table-eval-formula
        (kbd "M-o")    'my/org-insert-heading-after-current
        (kbd "M-O")    'my/org-insert-todo-heading-after-current
        (kbd "<up>")   'outline-previous-visible-heading
        (kbd "<down>") 'outline-next-visible-heading
        (kbd "M-l")    'org-metaright
        (kbd "M-h")    'org-metaleft
        (kbd "M-k")    'org-metaup
        (kbd "M-j")    'org-metadown
        (kbd "M-L")    'org-shiftmetaright
        (kbd "M-H")    'org-shiftmetaleft
        (kbd "M-K")    'org-shiftmetaup
        (kbd "M-J")    'org-shiftmetadown
      )

      (evil-define-key 'insert org-mode-map
        [tab]           'org-cycle
        [S-iso-lefttab] 'org-shifttab
        [S-tab]         'org-shifttab
        [backtab]       'org-shifttab
      )

      (evil-define-key 'visual org-mode-map
        (kbd "M-l")    'my/org-metaright-visual
        (kbd "M-h")    'my/org-metaleft-visual
        (kbd "M-k")    'my/org-metaup-visual
        (kbd "M-j")    'zorg-cycle0rch/org-metadown-visual
        (kbd "M-L")    'my/org-shiftmetaright-visual
        (kbd "M-H")    'my/org-shiftmetaleft-visual
        (kbd "M-K")    'my/org-shiftmetaup-visual
        (kbd "M-J")    'my/org-shiftmetadown-visual
      )

      (evil-leader/set-key-for-mode 'org-mode
        "a" 'org-archive-subtree
        "E" 'org-set-effort
        "r" 'org-refile
        "s" 'org-schedule
        "d" 'org-deadline
        "x" 'org-ctrl-c-ctrl-c
        "X" (kbd "C-u C-c C-c")
        "S" (kbd "C-u C-c C-s")
        "D" (kbd "C-u C-c C-d")
        "ne" 'org-narrow-to-element
        "ns" 'org-narrow-to-subtree
        "nw" 'widen
        "oki" 'org-clock-in
      )

      ;; Define some Org-agenda specific commands
      (evil-define-key 'motion org-agenda-mode-map
        "t"            'org-agenda-todo
        "T"            'org-agenda-todo-yesterday
        "o"            'delete-other-windows
        "M"            'org-agenda-bulk-unmark
        "]"            'org-agenda-later
        "["            'org-agenda-earlier
        "."            'org-agenda-goto-today
        "r"            'org-agenda-refile
        "R"            'org-agenda-redo
        (kbd "<up>")   'org-agenda-previous-item
        (kbd "<down>") 'org-agenda-next-item
      )

      (evil-leader/set-key-for-mode 'org-agenda-mode
        "n"   'my/org-agenda-filter-by-category
        "B"   'org-agenda-bulk-action
        "j"   'org-agenda-goto
        "s"   'org-agenda-schedule
        "d"   'org-agenda-deadline
        "v"   'org-agenda-view-mode-dispatch
        "x"   'org-agenda-set-tags
        "oki" 'org-agenda-clock-in
        "/"   'org-agenda-filter-by-tag
        "S"   (kbd "C-u C-c C-s")
        "D"   (kbd "C-u C-c C-d")
      )
)))


(provide 'init-org-mode)
;;; init-org-mode ends here
