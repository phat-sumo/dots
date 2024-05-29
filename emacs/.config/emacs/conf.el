(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(setopt org-pretty-entities t)
(setopt org-hide-emphasis-markers t)
(setopt org-catch-invisible-edits 'show-and-error)
(setopt org-return-follows-link t)
(org-indent-mode)

;; treat angle brackets sanely
(add-hook 'org-mode-hook (lambda () (modify-syntax-entry ?> ".")))
(add-hook 'org-mode-hook (lambda () (modify-syntax-entry ?< ".")))
;; actually escape strings please
(add-hook 'org-mode-hook (lambda () (modify-syntax-entry ?\\ "\\")))

(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("se" . "src emacs-lisp"))

(use-package org-modern
  :hook (org-ode . org-modern-mode)
  :init (global-org-modern-mode))

(use-package org-appear
  :custom (org-appear-autoentities t)
  :hook (org-mode . org-appear-mode))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/docs/org-roam")
  (org-roam-capture-templates
    '(("d" "default" plain "%?"
      :target (file+head "${slug}.org" "#+created: %<%Y-%m-%d%d:%H%M%S>\n#+title: ${title}")
      :unnarrowed t)))

  (org-roam-dailies-directory "~/docs/org-roam/dailies")
  (org-roam-dailies-capture-templates
   '(("d" "default" entry
       "* %?"
       :target (file+head "%<%Y-%m-%d>.org"
                          "#+title: %<%Y-%m-%d>\n"))))
  :config
  (org-roam-db-autosync-mode))

(when (daemonp)
  (use-package org-roam-ui
    :after org-roam
    :custom
    (org-roam-ui-sync-theme t)
    (org-roam-ui-follow t)
    (org-roam-ui-update-on-save t)
    :config
    (org-roam-ui-mode)))

(defun org-roam-goto-todo ()
  (interactive)
  (org-roam-node-visit (org-roam-node-from-title-or-alias "todo") t))

(use-package evil
  :demand t
  :after undo-tree
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-minibuffer t)
  :custom
  (evil-undo-system 'undo-tree)
  (evil-want-C-u-scroll t)
  (evil-want-C-u-delete t)
  (evil-want-C-i-jump t)
  (evil-want-integration t)
  (evil-auto-indent nil)
  (evil-shift-width 2)
  :config
  (setq evil-default-cursor        'hbar
        evil-normal-state-cursor   'hbar
        evil-insert-state-cursor   'hbar
        evil-visual-state-cursor   'hbar
        evil-motion-state-cursor   'hbar
        evil-replace-state-cursor  'hbar
        evil-operator-state-cursor 'hbar)
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
  (define-key evil-insert-state-map (kbd "C-v") 'cua-paste)
  (with-eval-after-load 'evil-maps
    (define-key evil-motion-state-map (kbd "RET") nil))
  (evil-mode))

(use-package drag-stuff
  :config
  (define-key drag-stuff-mode-map (drag-stuff--kbd 'k) 'drag-stuff-up)
  (define-key drag-stuff-mode-map (drag-stuff--kbd 'j) 'drag-stuff-down)
  (define-key drag-stuff-mode-map (drag-stuff--kbd 'h) 'drag-stuff-right)
  (define-key drag-stuff-mode-map (drag-stuff--kbd 'l) 'drag-stuff-left)
  (setq drag-stuff-modifier '(meta shift))
  (drag-stuff-global-mode))

;; (define-key evil-motion-state-map (kbd "SPC") nil)
;; (define-key evil-motion-state-map (kbd "TAB") nil)

  (use-package undo-tree
    :demand t
    :custom ((undo-tree-auto-save-history t)
       (undo-tree-history-directory-alist '(("." . "~/.config/emacs/undo"))))
    :config
    ;; by default, undo-tree will panic and break if it's bindings are overridden
    ;; this is _not_ helpful, so just redefine that to nil
    (defun undo-tree-overridden-undo-bindings-p () nil)
    ;; prevent undo-tree from writing unnecessary info to the echo area,
    ;; dumping it to **Messages** instead
    (defun undo-tree-save-history-suppress (undo-tree-save-history &rest args)
(let ((message-log-max nil)
      (inhibit-message t))
  (apply undo-tree-save-history args)))
    (advice-add 'undo-tree-save-history :around 'undo-tree-save-history-suppress)
    (global-undo-tree-mode))

  (elpaca-wait)

(use-package evil-commentary
    :config
    (evil-commentary-mode))

  (use-package evil-collection
    :after evil
    :ensure t
    :config
    (evil-collection-init))

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode t))

(defun quit-by-context ()
  (interactive)
  (if (= (length (window-list)) 1)
    (kill-buffer)
    (kill-buffer-and-window)))

  (defun save-buffer-and-quit ()
    (interactive)
    (save-buffer)
    (quit-by-context))

(evil-ex-define-cmd "q[uit]" 'quit-by-context)
(evil-ex-define-cmd "x[it]" 'save-buffer-and-quit)

(use-package format-all
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :config
  (setq-default format-all-formatters '(("C" (clang-format "-style=file:/home/phat_sumo/.clang-format"))
                                        ("Shell" (shfmt)))))

(defun save-buffer-no-format ()
  (interactive)
  (format-all-mode 0)
  (save-buffer)
  (format-all-mode 1))

(evil-ex-define-cmd "W[rite]" 'save-buffer-no-format)


;; (defun my-init-ex ()
;; ;; make ex commands buffer local
;; (make-local-variable 'evil-ex-commands)
;; ;; copy the original list (otherwise we would modify the global commands list)
;; (setq evil-ex-commands
;; (mapcar (lambda (cmd) (cons (car cmd) (cdr cmd)))
;;   (default-value 'evil-ex-commands)))
;; ;; redefine some commands
;; (evil-ex-define-cmd "wq[uit]" 'with-editor-finish))

;; thanks dawid
(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

(defun kill-buffer-and-frame ()
  (interactive)
  (kill-buffer)
  (delete-frame))

  (use-package evil-numbers
    :init
    (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
    (define-key evil-normal-state-map (kbd "C-S-a") 'evil-numbers/dec-at-pt))

  (use-package evil-org
    :ensure t
    :hook (org-mode . evil-org-mode)
    :config
    (require 'evil-org-agenda)
    (evil-org-agenda-set-keys))

  (use-package markdown-mode
    :ensure t
    :mode ("README\\.md\\'" . gfm-mode)
    :init (setq markdown-command "multimarkdown")
    :bind (:map markdown-mode-map
           ("C-c C-e" . markdown-do)))

  (use-package evil-markdown
    :ensure t
    :elpaca (:host github :repo "Somelauw/evil-markdown"))

  (use-package evil-replace-with-register
    :custom
    (evil-replace-with-register-key (kbd "gr"))
    :config
    (evil-replace-with-register-install))

(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay .5)
  (corfu-preselect 'prompt)
  (corfu-popupinfo-delay '(0.5 . 0.5))

  ;; optionally use tab for cycling, default is `corfu-complete'.
  ;; these need a little investigation first
  :bind (:map corfu-map
              ("M-SPC"      . corfu-insert-separator)
              ("TAB"        . corfu-next)
              ([tab]        . corfu-next)
              ("S-TAB"      . corfu-previous)
              ([backtab]    . corfu-previous)
              ("S-<return>" . corfu-insert)
              ("RET"        . nil))
  :hook
  ((prog-mode . corfu-mode))
  :config
  (global-corfu-mode)
  (corfu-history-mode)
  (corfu-popupinfo-mode))

(defun my/register-default-capfs ()
  "use 'cape-dabbrev' and 'cape-file' everywhere as they are
generally useful.  this function needs to be called in certain
mode hooks, as some modes fill the buffer-local capfs with
exclusive completion functions, so that the global ones don't get
called at all."
  (interactive)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

  ;; Add extensions
  (use-package cape
    :custom
    (cape-dabbrev-min-length 0)
    ;; Bind dedicated completion commands
    ;; Alternative prefix keys: C-c p, M-p, M-+, ...
    :bind (("C-c p p" . completion-at-point) ;; capf
           ("C-c p t" . complete-tag)        ;; etags
           ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
           ("C-c p h" . cape-history)
           ("C-c p f" . cape-file)
           ("C-c p k" . cape-keyword)
           ("C-c p s" . cape-elisp-symbol)
           ("C-c p e" . cape-elisp-block)
           ("C-c p a" . cape-abbrev)
           ("C-c p l" . cape-line)
           ("C-c p w" . cape-dict)
           ("C-c p :" . cape-emoji)
           ("C-c p \\" . cape-tex)
           ("C-c p _" . cape-tex)
           ("C-c p ^" . cape-tex)
           ("C-c p &" . cape-sgml)
           ("C-c p r" . cape-rfc1345))
    :hook ((haskell-mode . my/register-default-capfs))
    :init
    ;; Add to the global default value of `completion-at-point-functions' which is
    ;; used by `completion-at-point'.  The order of the functions matters, the
    ;; first function returning a result wins.  Note that the list of buffer-local
    ;; completion functions takes precedence over the global list.
    ;; (add-to-list 'completion-at-point-functions #'cape-dabbrev)
    ;; (add-to-list 'completion-at-point-functions #'cape-file)
    ;; (add-to-list 'completion-at-point-functions #'cape-elisp-block)
    ;;(add-to-list 'completion-at-point-functions #'cape-history)
    ;;(add-to-list 'completion-at-point-functions #'cape-keyword)
    ;;(add-to-list 'completion-at-point-functions #'cape-tex)
    ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
    ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
    ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
    ;;(add-to-list 'completion-at-point-functions #'cape-dict)
    ;;(add-to-list 'completion-at-point-functions #'cape-elisp-symbol)
    ;;(add-to-list 'completion-at-point-functions #'cape-line)
    (my/register-default-capfs))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package flycheck-haskell
  :hook (haskell-mode . flycheck-haskell-setup))

(use-package lua-mode
  :ensure t
  :custom
  (lua-indent-level 2)
  :config
  (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
  (add-to-list 'interpreter-mode-alist '("lua" . lua-mode)))

(use-package haskell-mode
  :ensure t
  :mode "\\.hs\\'"
  :hook (;;(haskell-mode . interactive-haskell-mode)
         (haskell-mode . turn-on-haskell-doc-mode)
         (haskell-mode . haskell-indent-mode)
         (haskell-mode . haskell-setup-outline-mode))
  :bind (
        :map haskell-mode-map
        ("M-n" . haskell-goto-next-error)
        ("M-n" . haskell-goto-prev-error)))

(use-package lsp-mode
  :ensure t
  :config
  :init
  (setq lsp-completion-provider :none)
  ;; (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-keymap-prefix "C-c k")
  (setq lsp-clients-lua-language-server-bin
        "/usr/bin/lua-language-server")
  (setq lsp-clients-lua-language-server-install-dir
        "/usr/lib/lua-language-server")
  (setq lsp-clients-lua-language-server-main-location
        "/usr/lib/lua-language-server/main.lua")
  (defun my/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
                             '(flex)))
  :hook ((lsp-completion-mode . my/lsp-mode-setup-completion)
         (c-mode                . lsp)
         (lua-mode              . lsp)
         (haskell-mode          . lsp)
         (haskell-literate-mode . lsp)
         (lsp-mode              . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-haskell
  :ensure t
  :init
  :hook (haskell-mode . lsp-deferred))

(use-package lsp-ui :commands lsp-ui-mode)

;; necessary so the bar doesn't get weird
(use-package all-the-icons
  :ensure t)

(use-package rainbow-mode
  :ensure t
  :hook ((c-mode    . rainbow-mode)
         (conf-mode . rainbow-mode)))

;; (set-frame-parameter nil 'internal-border-width 10)
(add-to-list 'default-frame-alist '(internal-border-width . 10))

(use-package rainbow-delimiters
  :ensure t
  :hook ((org-mode  . rainbow-delimiters-mode)
         (lisp-mode . rainbow-delimiters-mode)))


(use-package nerd-icons
  :ensure t)

(defun theme-config (&optional frame)
  (use-package doom-modeline
    :ensure t
    :custom
    (doom-modeline-height 10)
    :config
    (doom-modeline-mode 1))
  (use-package doom-themes
    :ensure t
    :custom
    (doom-themes-enable-bold   t)
    (doom-themes-enable-italic t)
    :config
    (load-theme 'doom-meltbus t)
    ;; flashing mode-line on error
    (doom-themes-visual-bell-config)))

  (theme-config)

(defun frame-config (&optional frame)
  (setq inhibit-startup-screen t
    frame-resize-pixelwise t)
  (menu-bar-mode 0)
  (tool-bar-mode 0)
  (scroll-bar-mode 0)
  (setq-default cursor-type 'hbar)
  (setq-default cursor-in-non-selected-windows 'hollow))

(add-to-list 'after-make-frame-functions 'theme-config 'frame-config)


;; eventually add:
; (doom-themes-org-config)

(use-package ligature
  :load-path "path-to-ligature-repo"
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
  ;; hopefully these are all in fira code too lol
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                      ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                      "!!." ">=>" ">>=" ">>>" ">>-" ">->" "-->" "-->" "---" "-<<"
                                      "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                      "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                      "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                      "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                      "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                      ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                      "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                      "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                      "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                      "\\\\" "://"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))


;; and even more eventually
; https://discourse.doomemacs.org/t/how-to-switch-customize-or-write-themes/37

(elpaca-wait)

(toggle-scroll-bar -1)


(defun set-font-pixelsize (value)
  (interactive "nnew pixelsize:")
  (set-frame-font (concat "monospace:pixelsize="
                          (prin1-to-string (set 'font-pixelsize value)))
                  nil t))

(defun init-font-pixelsize (&optional frame)
  (set-font-pixelsize (setq font-pixelsize 10)))

(init-font-pixelsize)

(add-to-list 'after-make-frame-functions 'init-font-pixelsize)

(setq warning-minimum-level :error)

(set-fringe-mode nil)

(use-package which-key
  :ensure t
  :config
  (which-key-setup-side-window-right-bottom)
  (which-key-mode))

(use-package exec-path-from-shell
  :ensure t
  :config
  ;; (add-to-list 'after-make-frame-functions 'exec-path-from-shell)
  (exec-path-from-shell-initialize))

(use-package ag
  :ensure t)

;; allow reopening file as root
(use-package sudo-edit
  :ensure t)

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode t))

(setq initial-scratch-message "")

(setq help-window-select t)

;; don't follow symlinks to their real locations
(setq vc-follow-symlinks nil)

;; sane scrolling values
(setq scroll-conservatively 101)
(setq scroll-margin 3)

(pixel-scroll-precision-mode t)
(setq pixel-scroll-precision-large-scroll-height 100)

(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-scroll-amount '(1 ((shift) . hscroll)))

;; (setq scroll-step 1)

;; (setq mouse-wheel-scroll-amount '(2 ((shift) . 10) ((control) . nil)))

(defun scratch-width ()
  (set-frame-size (selected-frame) 1900 300 t))

(setq tab-always-indent 'complete)
(setq tab-width 2)
(setq sh-basic-offset 2)

(setq sentence-end-double-space nil)

(setq frame-inhibit-implied-resize t)

(setq show-trailing-whitespace t)
(add-hook 'before-save-hook #'delete-trailing-whitespace)

(setq uniquify-buffer-name-style 'forward)

(setq save-place-file (locate-user-emacs-file "places"))
(save-place-mode t)

(setq use-short-answers t)
(setq use-dialog-box t)

(defun delete-current-file ()
  (interactive)
  (if (y-or-n-p (format "delete %s?" (buffer-name)))
      (delete-file (buffer-file-name))
      (princ (format "spared %s" (buffer-name)))))

(setq auth-source-save-behavior nil)

(defun delete-array-from-list-by-first-elem (list target)
  (dolist (item list)
    (print item)
    (when (equal target (aref item 0))
      (delete item list))))

(delete-array-from-list-by-first-elem jka-compr-compression-info-list "\\.g?z\\'")

(add-to-list 'jka-compr-compression-info-list
      ["\\[^\\.z].z\\'" "compressing" "gzip"
        ("-c" "-q")
        "uncompressing" "gzip"
        ("-c" "-q" "-d")
        t t "\37\213" zlib-decompress-region])

(add-to-list 'jka-compr-compression-info-list
      ["\\.gz\\'" "compressing" "gzip"
        ("-c" "-q")
        "uncompressing" "gzip"
        ("-c" "-q" "-d")
        t t "\37\213" zlib-decompress-region])

(global-visual-line-mode)

(make-directory "~/.config/emacs/backups" t)
(make-directory "~/.config/emacs/autosave" t)
(setq auto-save-file-name-transforms '((".*" "~/.config/emacs/autosave" t)))
(setq backup-directory-alist '(("." . "~/.config/emacs/backups")))
(setq backup-by-copying t)

(evil-set-leader 'normal (kbd "SPC"))
(evil-define-key 'normal 'global
  (kbd "<leader>w")  'save-buffer
  (kbd "<leader>W")  'save-buffer-no-format
  (kbd "<leader>x")  'save-buffer-and-quit
  (kbd "<leader>!")  'kill-buffer-and-frame
  (kbd "<leader>q")  'quit-by-context
  (kbd "<leader>Q")  'delete-window
  (kbd "<leader>f")  'org-roam-node-find
  (kbd "<leader>c")  'org-roam-capture
  (kbd "<leader>d")  'org-roam-dailies-goto-today
  (kbd "<leader>t")  'org-roam-goto-todo
  (kbd "<leader>%")  'split-and-follow-vertically
  (kbd "<leader>\"") 'split-and-follow-horizontally)

(require 'bind-key)

(defvar my-keys-minor-mode-map
  (make-sparse-keymap)
  "my-keys-minor-mode keymap.")

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my keybinds override any other mode."
  :init-value t)

(add-hook 'after-load-functions 'my-keys-have-priority)

(defun my-keys-have-priority (_file)
  "Ensure that my keybindings retain priority over other minor modes.

Called via the `after-load-functions special hook."
  (unless (eq (caar minor-mode-map-alist) 'my-keys-minor-mode)
    (let ((mykeys (assq 'my-keys-minor-mode minor-mode-map-alist)))
      (assq-delete-all 'my-keys-minor-mode minor-mode-map-alist)
      (add-to-list 'minor-mode-map-alist mykeys))))


(defun load-conf ()
  (interactive)
  (find-file "~/.config/emacs/conf.org"))

(bind-key "C-c x" 'load-conf 'my-keys-minor-mode-map)

;; maybe bind this to something?
(bind-key "C-c n" 'display-line-numbers-mode 'my-keys-minor-mode-map)
(setq display-line-numbers-type 'relative)


(bind-key "C-+" (lambda ()
                  (interactive) (set-font-pixelsize (+ font-pixelsize 1)))
                'my-keys-minor-mode-map)
(bind-key "C-_" (lambda ()
                  (interactive) (set-font-pixelsize (- font-pixelsize 1)))
                'my-keys-minor-mode-map)
(bind-key "C-)" (lambda ()
                  (interactive) (set-font-pixelsize 10))
                'my-keys-minor-mode-map)

(use-package fzf
  :bind
  ;; todo: add some
  :config
  (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
      fzf/executable "fzf"
      fzf/git-grep-args "-i --line-number %s"
      ;; command used for `fzf-grep-*` functions
      ;; example usage for ripgrep:
      ;; fzf/grep-command "rg --no-heading -nH"
      fzf/grep-command "grep -nrH"
      ;; If nil, the fzf buffer will appear at the top of the window
      fzf/position-bottom t
      fzf/window-height 15))
