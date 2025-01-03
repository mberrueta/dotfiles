(setq debug-on-error nil)

(when (eq system-type 'gnu/linux)
    (use-package! xclip
    :config
    (setq xclip-program "wl-copy")
    (setq xclip-select-enable-clipboard t)
    (setq xclip-mode t)
    (setq xclip-method (quote wl-copy)))
    (setq xclip-select-enable-clipboard t)
)


(setq select-enable-clipboard t)        ; Use the clipboard for cut/copy/paste
(setq select-enable-primary t)          ; Integrate with primary X11 selection
(setq x-select-enable-clipboard-manager nil) ; Don't use clipboard manager
(require 'clipetty)
(global-clipetty-mode)
(global-set-key (kbd "M-Y") 'consult-yank-from-kill-ring)
(global-set-key (kbd "C-S-c") 'clipboard-kill-ring-save)  ; Copy
(global-set-key (kbd "C-S-x") 'clipboard-kill-region)     ; Cut
(global-set-key (kbd "C-S-v") 'clipboard-yank)           ; Paste

(setq doom-font (font-spec :family "Caskaydia Cove Nerd Font" :size 15 )
    doom-variable-pitch-font (font-spec :family "Caskaydia Cove Nerd Font" :size 15))

(setq doom-theme 'doom-dark+)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative) ; Options: t, nil, 'relative

;; which key popup to right
(use-package which-key
    :config (progn
            (push '((nil . "projectile") . (nil . "proj")) which-key-replacement-alist)
            (setq which-key-idle-delay 0.4) ; default is 1.0
            (setq which-key-side-window-max-width 0.9) ; default 0.333
            (setq which-key-side-window-max-height 1)  ; default 0.5
            (setq which-key-show-early-on-C-h t)
            (which-key-mode)
            (which-key-setup-side-window-right))
  :diminish which-key-mode)

;; Help to right
(after! help
  (set-popup-rule! "^\\*Help" :side 'right :size 0.5 :select t))

(unless (display-graphic-p)
          (require 'evil-terminal-cursor-changer)
          (evil-terminal-cursor-changer-activate) ; or (etcc-on)
          (setq evil-normal-state-cursor 'box)  ; █
          (setq evil-visual-state-cursor 'hbar)  ; █
          (setq evil-motion-state-cursor 'hbar)  ; █
          (setq evil-insert-state-cursor 'bar)  ; ⎸
          (setq evil-emacs-state-cursor  'hbar) ; _
          )

(after! eww
  (set-popup-rule! "^\\*eww" :ignore t))

(ace-link-setup-default)

(setq browse-url-browser-function 'eww-browse-url
      shr-use-colors nil
      shr-bullet "• "
      shr-folding-mode t
      eww-search-prefix "https://duckduckgo.com/html?q="
      url-privacy-level '(email agent cookies lastloc))

(defun my-eww-reuse-buffer (orig-fun &rest args)
  "Advice to make `eww' reuse the same buffer."
  (let ((url (car args))
        (buffer (get-buffer "*eww*")))
    (if (and buffer (not (eq (current-buffer) buffer)))
        (progn
          (switch-to-buffer buffer)
          (eww url))  ; Call `eww` with the url in the existing buffer.
      (apply orig-fun args))))  ; Otherwise, open EWW normally.

(advice-add 'eww :around #'my-eww-reuse-buffer)


(map! :leader
      (:prefix ("o". "open")
       :desc "Web Wrowser"       "w" `eww
       ))

(require 'winum)
(winum-mode)

(map! :leader "TAB" `mode-line-other-buffer)
(map! :leader "SPC" `switch-to-buffer)
(map! :leader "W"   `evil-window-prev)
(map! :leader "0" `winum-select-window-0)
(map! :leader "1" `winum-select-window-1)
(map! :leader "2" `winum-select-window-2)
(map! :leader "3" `winum-select-window-3)
(map! :leader "4" `winum-select-window-4)
(map! :leader "5" `winum-select-window-5)
(map! :leader "6" `winum-select-window-6)
(map! :leader "7" `winum-select-window-7)
(map! :leader "8" `winum-select-window-8)
(map! :leader "9" `winum-select-window-9)

(defun toggle-window-position ()
  "Toggle between horizontal and vertical split with two windows."
  (interactive)
  (if (> (length (window-list)) 2)
      (error "Can't toggle with more than 2 windows!")
    (let ((func (if (window-full-height-p)
                    #'split-window-vertically
                  #'split-window-horizontally)))
      (delete-other-windows)
      (funcall func)
      (save-selected-window
        (other-window 1)
        (switch-to-buffer (other-buffer))))))
;; Assigned to leader w t

(defun save-all () (interactive) (save-some-buffers t))

(global-unset-key (kbd "C-j"))
(global-unset-key (kbd "M-j"))

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-j") nil)
  (define-key org-mode-map (kbd "M-j") nil))



(global-set-key (kbd "C-S") 'save-all)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-U") 'evil-redo)

;; Map Ctrl+h/j/k/l to arrow keys
(global-set-key (kbd "C-h") 'backward-char)  ; Left
(global-set-key (kbd "C-j") 'next-line)      ; Down
(global-set-key (kbd "C-k") 'previous-line)  ; Up
(global-set-key (kbd "C-l") 'forward-char)   ; Right

(with-eval-after-load 'evil
  (define-key evil-insert-state-map (kbd "C-j") 'next-line)
  (define-key evil-insert-state-map (kbd "C-k") 'previous-line))

;; Map Shift+h/l (start/end of line)
(global-set-key (kbd "C-S-h") 'move-beginning-of-line)
(global-set-key (kbd "C-S-l") 'move-end-of-line)

;; Map Shift+j/k (previous/next word)
(global-set-key (kbd "C-S-B") 'backward-word)
(global-set-key (kbd "C-S-W") 'forward-word)

;; Map Ctrl+Backspace to delete one word to the left
(global-set-key (kbd "C-<backspace>") 'backward-kill-word)

;; Map Ctrl+Delete to delete one word to the right
(global-set-key (kbd "C-<delete>") 'kill-word)

;; In normal mode ? show keys, and C-p allow to filter
(require 'embark)
(after! evil
  (map! :n "?" #'which-key-show-top-level)
  (map! :n "C-p" #'embark-bindings)
  )
(global-set-key (kbd "<f1>") 'embark-bindings)

;; Alt l recenter
(global-set-key (kbd "M-l") 'recenter-top-bottom)

;; H -> top, M -> Middle , L -> bottom

(global-set-key (kbd "C-o") 'evil-jump-backward)
(global-set-key (kbd "C-O") 'evil-jump-forward)


(drag-stuff-global-mode 1)
(global-set-key (kbd "M-k") 'drag-stuff-up);; Move line or selection up
(global-set-key (kbd "M-j") 'drag-stuff-down) ;; Move line or selection down




(global-set-key (kbd "M-h") 'indent-selection-or-line-left)   ;; Indent left




(global-set-key (kbd "M-l") 'indent-selection-or-line-right)  ;; Indent right

(global-set-key (kbd "M-J") 'duplicate-dwim)


(map! :leader
      (:prefix ("w". "window/web")
       :desc "switch to alternate window"       "w" `other-window
       :desc "toggle Vertical/Horizontal"       "t" `toggle-window-position
       :desc "resize"                           "r" `windresize
       :desc "kill"                             "k" `quit-window
       :desc "kill others"                      "K" `delete-other-windows
       :desc "next"                             "]" `windresize-next-window
       :desc "prev"                             "[" `windresize-previous-window

       :desc "Open Web browser"                 "o" `eww
       )
      (:prefix ("b". "buffer / bookmark")
       :desc "clone buffer"                     "c" `clone-buffer
       :desc "rename buffer"                    "r" `rename-buffer
       :desc "list bookmarks"                   "l" `consult-bookmark
       :desc "bookmark set"                     "s" `bookmark-set
       :desc "bookmark remove"                  "S" `bookmark-delete
       :desc "Scratch buffer"                   "n" `scratch-buffer
))



(after! eww
  (map! :map eww-mode-map
        :n "TAB"         #'shr-next-link
        :n "<backtab>"   #'shr-previous-link  ;; Shift + TAB
        :n "b"           #'eww-add-bookmark
        :n "B"           #'eww-list-bookmarks
        :n "l"           #'eww-back-url
        :n "r"           #'eww-forward-url
        :n "H"           #'eww-history
        :n "w"           #'eww-copy-page-url
        :n "M-<RET>"     #'eww-open-in-new-buffer
        :n "s"           #'eww-list-tabs))

(use-package direnv
  :config
  (direnv-mode))

(setq avy-all-windows t)
(map! :leader
      (:prefix ("j". "jump")
       :desc "To word"            "w" `avy-goto-word-1
       :desc "To char"            "c" `avy-goto-char
       :desc "To line"            "l" `avy-goto-line
       :desc "Back"               "b" `evil-jump-backward
       :desc "Forward"            "f" `evil-jump-forward
       :desc "Jumps History"      "h" `+vertico/jump-list
       :desc "Web"                "W" `webjump
       ))

;; # ys add surround ex:   ys iW "
;; # ds delete sur   ex:   ds '
;; # cs replace sur  ex:   cs ] )

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(map! :leader
      (:prefix ("g". "Git")
       :desc "Toggle timemachine"            "t" `git-timemachine-toggle
       :desc "Timemachine prev (C-p)"        "p" `git-timemachine-show-previous-revision
       :desc "Timemachine next (C-n)"        "n" `git-timemachine-show-next-revision
))

(require 'origami) ; folding
(use-package origami
  :init
  (global-origami-mode)
  (evil-define-key 'normal global-map (kbd "z t") 'origami-toggle-node)
  (evil-define-key 'normal global-map (kbd "z o") 'origami-open-node)
  (evil-define-key 'normal global-map (kbd "z O") 'origami-open-node-recursively)
  (evil-define-key 'normal global-map (kbd "z C") 'origami-close-all-nodes)
  (evil-define-key 'normal global-map (kbd "z c") 'origami-close-node-recursively))

;; (require 'perspective)
;; (global-set-key (kbd "C-x C-b") 'persp-list-buffers)
;; (customize-set-variable 'persp-mode-prefix-key (kbd "C-x p"))
;; (persp-mode)
;; (add-hook 'kill-emacs-hook #'persp-state-save)

(use-package treemacs
  :defer t
  :init
  (display-line-numbers-mode t)
  :bind
  )
(add-hook 'treemacs-mode-hook (lambda() (display-line-numbers-mode t)))
(use-package treemacs-evil
  :after (treemacs evil))

(use-package treemacs-projectile
  :after (treemacs projectile))

;; prevent dired open multiple buffers
(setf dired-kill-when-opening-new-dired-buffer t)

;; (use-package treemacs-icons-dired
;;   :hook (dired-mode . treemacs-icons-dired-enable-once)
;;   :ensure t)

;; (use-package treemacs-magit
;;   :after (treemacs magit)
;;   :ensure t)

;; (use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
;;   :after (treemacs persp-mode) ;;or perspective vs. persp-mode
;;   :ensure t
;;   :config (treemacs-set-scope-type 'Perspectives))

;; (use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
;;   :after (treemacs)
;;   :ensure t
;;   :config (treemacs-set-scope-type 'Tabs))

;; (with-eval-after-load 'treemacs
  ;;   (treemacs-define-RET-action 'file-node-closed #'treemacs-visit-node-ace)
  ;;   (treemacs-define-RET-action 'file-node-open #'treemacs-visit-node-ace))

(map! :leader "0" `treemacs-select-window)

(map! :leader
      (:prefix ("t". "treemacs")
       :desc "tootle treemacs"       "t" `treemacs
       :desc "select folder"         "f" `treemacs-select-directory
       :desc "help"                  "?" `treemacs-common-helpful-hydra
       :desc "move file"             "m" `treemacs-move-file
       :desc "create file"           "n" `treemacs-create-file
       :desc "create dir"            "N" `treemacs-create-dir
       :desc "clone file"            "c" `treemacs-copy-file
       :desc "delete file"           "d" `treemacs-delete-file
       :desc "Add bookmark"          "b" `treemacs-add-bookmark
       :desc "Find bookmark"         "B" `treemacs-bookmark
       :desc "Collapse all"          "f" `treemacs-collapse-all-projects

       :desc "Run command here"      "!" `treemacs-run-shell-command-for-current-node




       )
      )

(map! "M-/" `comment-line)

(setq
 gptel-model 'llama3.2:latest
 gptel-backend (gptel-make-ollama "Ollama"
                 :host "127.0.0.1:11434"
                 :stream t
                 :models '(llama3.2:latest)))



;; Enable highlight-indent-guides-mode in all buffers
(global-display-fill-column-indicator-mode t)

(require 'highlight-indent-guides)
(add-hook 'after-init-hook (lambda ()
    (add-hook 'after-change-major-mode-hook
        (lambda ()
            (highlight-indent-guides-mode 1)))))

(setq highlight-indent-guides-method 'character)
(setq highlight-indent-guides-auto-enabled nil)
(set-face-background 'highlight-indent-guides-odd-face "darkgray")
(set-face-background 'highlight-indent-guides-even-face "dimgray")
(set-face-foreground 'highlight-indent-guides-character-face "dimgray")

(use-package transient)

;; (use-package smerge-mode
;;   :hook
;;   (prog-mode . my/enable-smerge-detection))  ;; Hook for enabling conflict detection in programming modes

;; (defun my/smerge-check-and-enable ()
;;   "Check for conflict markers and enable or refresh smerge-mode if found."
;;   (interactive)
;;   (save-excursion
;;     (goto-char (point-min))
;;     (if (re-search-forward "^<<<<<<< " nil t)
;;         (progn
;;           (unless smerge-mode
;;             (smerge-mode 1))   ;; Enable smerge-mode if not already enabled
;;           (my/smerge-enable-all-conflicts))
;;       (when smerge-mode
;;         (smerge-mode -1)))))  ;; Disable smerge-mode if no conflicts found

;; (defun my/smerge-enable-all-conflicts ()
;;   "Go through all conflicts in the buffer and ensure they are properly detected by smerge."
;;   (save-excursion
;;     (goto-char (point-min))
;;     (while (re-search-forward "^<<<<<<< " nil t)
;;       (smerge-next)
;;       (smerge-auto-leave))))

;; (defun my/smerge-enable-on-change (&rest _)
;;   "Run conflict check and enable/disable smerge-mode after buffer changes.
;; Ignore the arguments passed by after-change-functions."
;;   (my/smerge-check-and-enable))

;; ;; Optional transient menu to help with conflict resolution
;; (defun my/smerge-show-conflict-menu ()
;;   "Show a transient action menu for resolving smerge conflicts."
;;   (interactive)
;;   (transient-define-prefix my/smerge-transient ()
;;     "Smerge conflict resolution menu"
;;     ["Actions"
;;      ("c" "Accept Current (ours)" smerge-keep-current)
;;      ("t" "Accept Theirs" smerge-keep-other)
;;      ("b" "Accept Both" smerge-keep-all)
;;      ("n" "Next Conflict" smerge-next)
;;      ("p" "Previous Conflict" smerge-prev)]
;;     ["Exit"
;;      ("q" "Quit" transient-quit-one)])
;;   (my/smerge-transient))

;; ;; Optional key bindings for quick conflict resolution
;; (with-eval-after-load 'smerge-mode
;;   (define-key smerge-mode-map (kbd "C-c C-m") 'my/smerge-show-conflict-menu)  ;; Keybinding to show the conflict menu
;;   (define-key smerge-mode-map (kbd "C-c c") 'smerge-keep-current)  ;; Accept current change (ours)
;;   (define-key smerge-mode-map (kbd "C-c t") 'smerge-keep-other)    ;; Accept other change (theirs)
;;   (define-key smerge-mode-map (kbd "C-c b") 'smerge-keep-all)      ;; Keep both changes
;;   (define-key smerge-mode-map (kbd "C-c n") 'smerge-next)          ;; Jump to next conflict
;;   (define-key smerge-mode-map (kbd "C-c p") 'smerge-prev))         ;; Jump to previous conflict

;; ;; Initial hook to ensure smerge runs after changes
;; (add-hook 'after-change-functions #'my/smerge-enable-on-change nil t)

(unless (package-installed-p 'evil)
  (package-refresh-contents)
  (package-install 'evil))

(require 'evil)
(evil-mode 1)

(unless (package-installed-p 'evil-nerd-commenter)
  (package-refresh-contents)
  (package-install 'evil-nerd-commenter))

(require 'evil-nerd-commenter)


(defun my/evil-next-method ()
  "Move to the next method in Dart, Elixir, or Ruby."
  (interactive)
  (next-line)
  (re-search-forward "class\\|def\\|defp\\|defmodule\\|\\w*\(.*{" )
  (beginning-of-line))

(defun my/evil-previous-method ()
  "Move to the previous method in Dart, Elixir, or Ruby."
  (interactive)
  (previous-line)
  (re-search-backward "class\\|def\\|defp\\|defmodule\\|\\w*\(.*{" )
  (beginning-of-line))

(define-key evil-normal-state-map (kbd "]]") 'my/evil-next-method)
(define-key evil-normal-state-map (kbd "[[") 'my/evil-previous-method)



(add-hook 'after-save-hook 'helm-backup-versioning)

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package tree-sitter
  :hook (elixir-mode . tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :after tree-sitter
  :config
  (tree-sitter-require 'elixir)
  (add-to-list 'tree-sitter-major-mode-language-alist
               '(elixir-mode . elixir)))

;; Disable Apheleia in HEEx mode
(add-hook 'heex-ts-mode-hook
          (lambda ()
            (apheleia-mode -1)))

;; TBD learn https://ebzzry.com/en/emacs-pairs/

(add-hook 'elixir-mode-hook 'mix-minor-mode)
(setq lsp-file-watch-ignored
      '(".idea" ".ensime_cache" ".eunit" "node_modules"
        ".git" ".hg" ".fslckout" "_FOSSIL_"
        ".bzr" "_darcs" ".tox" ".svn" ".stack-work"
        "build" "_build" "deps" "postgres-data")
      )

(use-package flycheck
  :delight " ✓"
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(require 'flycheck-mix)
(flycheck-mix-setup)

(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . right)
              (reusable-frames . visible)
              (window-height   . 0.33)))


(add-hook 'elixir-ts-mode-hook #'lsp)

(defun elixir-create-function (start end)
  "Create the function at the end of the buffer"
  (interactive "r")  ; The "r" means this function works on a region (selected text)
  (let ((selected-text (string-trim (buffer-substring-no-properties start end))))
    (goto-char (point-max))  ; Move to the end of the buffer
    (forward-line -1)
    (insert "defp " selected-text " do\n")  ; Insert the function definition
    (insert "  \n")  ; Placeholder for the function body
    (insert "end\n")
    (backward-char 6)))

;; (add-to-list 'exec-path "/home/matt/code/elixir/elixir-ls/_build/release")
;; (use-package
;;  eglot
;;  :ensure nil
;;  :config (add-to-list 'eglot-server-programs '(elixir-ts-mode "language_server.sh")))

;; (with-eval-after-load 'eglot
;;   (add-to-list 'eglot-server-programs
;;                `((elixir-ts-mode heex-ts-mode) .
;;                  ,(if (and (fboundp 'w32-shell-dos-semantics)
;;                            (w32-shell-dos-semantics))
;;                       '("language_server.bat")
;;                     (eglot-alternatives
;;                      '("/home/matt/code/elixir/lexical-lsp/bin/start_lexical.sh"))))))

;; (require 'eglot)

;; Next LS
;; (add-to-list 'exec-path "/media/hdd_3tb/matt/code/elixir/next-ls/burrito_out")
;; (with-eval-after-load 'eglot
;; (add-to-list 'eglot-server-programs
;;    `((elixir-ts-mode heex-ts-mode elixir-mode) .
;;      ("next_ls_linux_amd64" "--stdio=true" :initializationOptions (:experimental (:completions (:enable t)))))))


;; (add-hook 'elixir-mode-hook 'eglot-ensure)
;; (add-hook 'elixir-ts-mode-hook 'eglot-ensure)
;; (add-hook 'heex-ts-mode-hook 'eglot-ensure)

;; (defun my-display-eldoc-buffer (buffer alist)
;;   (display-buffer-in-side-window buffer '((side . right))))

;; (add-to-list 'display-buffer-alist
;;              '("*eldoc*"
;;                (display-buffer-in-side-window)
;;                (side . right)
;;                (slot . -1)
;;                (window-width . 0.3)))


;; (defun my-setup-elixir-env ()
;;   )

(defun my/toggle-eldoc-window ()
  "Toggle the visibility of the ElDoc side window."
  (interactive)
  (let ((window (get-buffer-window "*eldoc*")))
  (add-to-list 'display-buffer-alist
               '("*eldoc*"
                 (display-buffer-in-side-window)
                 (side . right)
                 (slot . -1)
                 (window-width . 0.3)))
    (if window
        (delete-window window)            ;; If window is visible, delete it
      (eldoc-print-current-symbol-info))))

;; (add-hook 'elxir-ts-mode-hook 'my-setup-elixir-env)
;; (add-hook 'elixir-mode-hook 'my-setup-elixir-env)

(require 'yasnippet)

(setq yas-snippet-dirs (append yas-snippet-dirs
                         '("~/.dotfiles/doom/.config/doom/snippets/")))

(yas-global-mode 1)

(with-eval-after-load 'elixir-ts-mode
  (map! :leader
        (:prefix ("c" . "Elixir Code")
          :desc "format code"                       "f" #'elixir-format
          :desc "Documentation "                    "d" #'eldoc-print-current-symbol-info
          :desc "Documentation Hide"                "D" #'my/toggle-eldoc-window ;eldoc-print-current-symbol-info
          ;; :desc "Create Function"                   "c" #'elixir-create-function
          ;; :desc "Open Documentation"                "d" #'elixir-mode-open-docs-stable

         (:prefix ("t" . "Tests / Toggle")
          :desc "run all test"                     "a" #'exunit-verify-all
          :desc "run single test"                  "s" #'exunit-verify-single
          :desc "run all in buffer"                "b" #'exunit-verify
          :desc "re-run test"                      "r" #'exunit-rerun
          :desc "Jump Code - Test"                 "t" #'exunit-toggle-file-and-test
          :desc "Jump Code - Test other window"    "T" #'exunit-toggle-file-and-test-other-window)


         (:prefix ("m" . "Mix")
          :desc "Execute task"                     "e" #'mix-execute-task
          :desc "Repeat"                           "r" #'mix-last-command
          :desc "Compile"                          "c" #'mix-compile)
         ;;  :desc ""                     "a" #'

        )))

(defun my-display-rspec-buffer (buffer alist)
  (display-buffer-in-side-window buffer '((side . right))))
;; Ensure the display buffer alist is set globally
(add-to-list 'display-buffer-alist
             '("\\*rspec-compilation\\*"
               (display-buffer-in-side-window)
               (side . right)
               (slot . -1)
               (window-width . 0.5)))

(defun my-setup-ruby-env ()
  "Set up environment for Ruby and RSpec."
  ;; Set up Flycheck to use bundle exec
  (setq-local flycheck-command-wrapper-function
              (lambda (command) (append '("bundle" "exec") command)))
  ;; Apply the display buffer rule
  (add-to-list 'display-buffer-alist
               '("\\*rspec-compilation\\*"
                 (display-buffer-in-side-window)
                 (side . right)
                 (slot . -1)
                 (window-width . 0.5))))

;; Add the setup function to the ruby-mode and rspec-mode hooks
(add-hook 'ruby-mode-hook 'my-setup-ruby-env)
(add-hook 'rspec-mode-hook 'my-setup-ruby-env)

;; Is not working properly (At least with CN)
(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(ruby-reek ruby-rubocop)))
(setq lsp-disabled-clients '(rubocop-ls))

(use-package flycheck-posframe
  :after flycheck
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode)
  (setq flycheck-posframe-position 'window-top-right-corner))

(map! :leader
      (:prefix ("c". "Code")
       "t" nil
       "e" nil))
(with-eval-after-load 'ruby-mode
  (map! :leader
        (:prefix ("c" . "Code")
          :desc "Format code"                       "f" #'rubocop-format-current-file
          :desc "Autocorrect Rubocop"               "F" #'rubocop-autocorrect-current-file

          (:prefix ("t" . "Tests / Toggle")
          :desc "Run all test"                     "a" #'rspec-verify-all
          :desc "Run single test"                  "s" #'rspec-verify-single
          :desc "Run all in buffer"                "b" #'rspec-verify
          :desc "Re-run test"                      "r" #'rspec-rerun
          :desc "Jump Code - Test"                 "t" #'rspec-toggle-spec-and-target
          )

         ;; (:prefix ("e" . "Exec")
         ;;    :desc "Execute task"                     "e" #'bundle-exec
         ;;    :desc "Bundle install"                   "i" #'bundle-install
         ;;    :desc "Console"                          "c" #'bundle-console          )
        )))


(with-eval-after-load 'eglot
 (add-to-list 'eglot-server-programs '((ruby-mode ruby-ts-mode) "ruby-lsp")))

(setq rubocop-check-command "bundle exec rubocop --lint --format emacs")
(setq rubocop-autocorrect-command "bundle exec rubocop -A --format emacs")

;; (require 'cl)
;; (require 'color)

;; (defun csv-highlight (&optional separator)
;;   (interactive (list (when current-prefix-arg (read-char "Separator: "))))
;;   (font-lock-mode 1)
;;   (let* ((separator (or separator ?\,))
;;          (n (count-matches (string separator) (point-at-bol) (point-at-eol)))
;;          (colors (loop for i from 0 to 1.0 by (/ 2.0 n)
;;                        collect (apply #'color-rgb-to-hex
;;                                       (color-hsl-to-rgb i 0.3 0.5)))))
;;     (cl-loop for i from 2 to n by 2
;;           for c in colors
;;           for r = (format "^\\([^%c\n]+%c\\)\\{%d\\}" separator separator i)
;;           do (font-lock-add-keywords nil `((,r (1 '(face (:foreground ,c)))))))))

;; (add-hook 'csv-mode-hook 'csv-highlight)
;; (add-hook 'csv-mode-hook 'csv-align-mode)
;; (add-hook 'csv-mode-hook '(lambda () (interactive) (toggle-truncate-lines nil)))

(with-eval-after-load 'dart-mode
  (map! :leader
        (:prefix ("c" . "Dart Code")
          :desc "format code"                       "f" #'lsp-format-buffer
          :desc "actions"                           "a" #'lsp-execute-code-action
          :desc "rename"                            "r" #'lsp-rename
          :desc "errors"                            "e" #'lsp-treemacs-errors-list
        )))


;; Add Flutter and Dart SDK paths
(setenv "PATH" (concat (getenv "PATH") ":/home/matt/.asdf/shims"))
(setq exec-path (append exec-path '("/home/matt/.asdf/shims")))

;; Set lsp-dart SDK directory if not already set
;; (setq lsp-dart-sdk-dir (or (getenv "DART_SDK") "/home/matt/.asdf/installs/dart/3.5.4"))
(setq lsp-dart-sdk-dir "/home/matt/.asdf/installs/flutter/3.24.4-stable/bin/cache/dart-sdk")
(setq lsp-dart-flutter-sdk-dir "/home/matt/.asdf/installs/flutter/3.24.4-stable")

;; Ensure lsp-mode starts for Dart files
(add-hook 'dart-mode-hook #'lsp)
(setq lsp-auto-guess-root t)


(setq lsp-treemacs-errors-position-params
      '((side . right) (slot . 0) (window-width . 0.4)))
(setq lsp-treemacs-symbols-position-params
      '((side . right) (slot . 0) (window-width . 0.4)))

(defun my-nix-mode-setup ()
  "Custom keybindings for Nix mode."
  (local-set-key (kbd "M-<right>") 'forward-word)
  (local-set-key (kbd "M-<left>") 'backward-word))

(add-hook 'nix-mode-hook 'my-nix-mode-setup)

(use-package rainbow-mode
  :hook (prog-mode . rainbow-mode))

(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'after-sgml-mode-hook
        (lambda ()
            (highlight-indent-guides-mode 1)))

(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(setq emmet-self-closing-tag-style " /") ;; default "/"


(with-eval-after-load 'sgml-mode
  (map! :leader
        (:prefix ("c" . "Html Code")
          :desc "Emmet complete"         "e" #'emmet-expand-line
          :desc "Emmet wrap region"      "w" #'emmet-wrap-with-markup
          :desc "Close tag"              "c" #'sgml-close-tag
          :desc "Attributes"             "a" #'sgml-attributes)))


; No anda esta mierda
; npm install -g rustywind
;; (use-package! lsp-tailwindcss
;;   :after lsp-mode
;;   :init
;;   (setq lsp-tailwindcss-add-on-mode t)
;;   (add-to-list 'lsp-language-id-configuration '("elixir-ts-mode" . "elixir"))
;; )
;; (add-hook 'before-save-hook 'lsp-tailwindcss-rustywind-before-save)


(add-hook 'prog-mode-hook #'rainbow-mode)
;; npm install -g prettier
;; .tools-version
;; nodejs 20.11.0
;; (add-hook 'rjsx-mode-hook 'prettier-js-mode)
;; (add-hook 'web-mode-hook 'prettier-js-mode)

(require 'nix-mode)
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

(defun get-eshell-buffer ()
  "Find the first buffer whose name matches the pattern *eshell*."
  (interactive)
  (let ((buffers (buffer-list))
        (pattern "\\*eshell.*\\*")  ; Regex pattern to match buffer names
        found-buffer)
    (while (and buffers (not found-buffer))
      (let ((buffer (car buffers)))
        (if (string-match-p pattern (buffer-name buffer))
            (setq found-buffer buffer)))
      (setq buffers (cdr buffers)))
    found-buffer))


(defun eshell-send-region (start end)
  "Send the selected region to an Eshell buffer."
  (interactive "r")
  (let ((command (buffer-substring-no-properties start end))
        (eshell-buffer (get-eshell-buffer)))
    (if (not eshell-buffer)
        (message "No Eshell buffer found.")
      (progn
        (with-current-buffer eshell-buffer
          (goto-char (point-max))
          (insert command)
          (eshell-send-input))
        (pop-to-buffer eshell-buffer)))))

(defun eshell-send-command (&optional copy-output)
  "Send a command to Eshell and optionally copy the output.
If COPY-OUTPUT is non-nil, the output is copied to the kill ring."
  (interactive "P")  ; "P" allows the function to be called with a prefix argument
  (let ((command (read-from-minibuffer "Command to send to Eshell: "))
        (eshell-buffer (get-eshell-buffer))
        output-start output-end)
    (if (not eshell-buffer)
        (message "No Eshell buffer found.")
      (progn
        (with-current-buffer eshell-buffer
          (goto-char (point-max))
          (setq output-start (point))
          (insert command)
          (eshell-send-input)
          ;; Wait for the command to complete
          (while (progn
                   (goto-char (point-max))
                   (not (looking-back eshell-prompt-regexp nil)))
            (sleep-for 0.1))
          (setq output-end (point))
          (when copy-output
            ;; Exclude the prompt from the copied output
            (kill-ring-save output-start (- output-end (length eshell-prompt-regexp)))
            (message "Command output copied to kill ring.")))
        (pop-to-buffer eshell-buffer)))))




(map! :leader
       (:prefix ("e". "exec")
       :desc "exec region in opened eshel"       "r" `eshell-send-region
       :desc "exec command in opened eshel"      "c" `eshell-send-command
       :desc "exec command and copy result"      "C" (λ! (eshell-send-command t))
       :desc "open eshell"                       "e" `projectile-run-eshell
       )
       (:prefix ("o". "open")
       :desc "open eshell"                       "e" `projectile-run-eshell
       )

)

(map! :leader
      "<" nil
      "x" nil
      "X" nil
      (:prefix ("w". "window/web")
       "-" nil
       "+" nil
       ">" nil
       "m" nil
       "=" nil
       "<" nil
       "k" nil
       "W" nil
       "_" nil
       "b" nil
       "c" nil
       "d" nil
       "f" nil
       "g" nil
       "h" nil
       "H" nil
       "j" nil
       "J" nil
       "l" nil
       "e" nil
       "L" nil
       "d" nil
       "p" nil
       "R" nil
       "T" nil
       "u" nil
       "|" nil
       "C-_" nil
       "C-b" nil
       "C-c" nil
       "C-f" nil
       "C-n" nil
       "C-o" nil
       "C-p" nil
       "C-q" nil
       "C-r" nil
       "C-s" nil
       "C-t" nil
       "C-u" nil
       "C-v" nil
       "C-w" nil
       "C-x" nil
       "C-S-r" nil
       "C-S-s" nil
       "C-S-w" nil
       "C-<down>" nil
       "C-<up>" nil)

      (:prefix ("b".)
       "-" nil ;; narrow buffer
       "c" nil ;; clone buffer
       "O" nil ;; kill other buff
       "p" nil ;; previous buff
       "r" nil ;; rename
       "u" nil ;; save as root
       "x" nil ;; scratch
       "X" nil ;; scratch
       "y" nil ;; yank buff
       "z" nil ;; bury b
       "Z" nil ;; kill
       "C" nil ;; clone
       "d" nil ;; kill
       "R" nil ;; rename
       "m" nil ;; bookmark
       "M" nil ;; renabookmark
       )

      (:prefix ("f".)
       "e" nil
       "E" nil
       "p" nil
       "P" nil)

      (:prefix ("i".)
       "y" nil
       "u" nil)
)

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "M-j") nil)
  (define-key org-mode-map (kbd "M-l") nil)
  (add-hook 'org-mode-hook 'my-org-mode-hook)
)


(defun my-org-mode-hook ()
  (let ((keys (mapcar 'car org-mode-map)))
    (dolist (key keys)
      (define-key org-mode-map key nil)))
)


